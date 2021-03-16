#!/bin/sh
#
#  msys2-sshd-setup.sh — configure sshd on MSYS2 and run it as a Windows service
#
#  Replaces ssh-host-config <https://github.com/openssh/openssh-portable/blob/master/contrib/cygwin/ssh-host-config>
#  Adapted from <https://ghc.haskell.org/trac/ghc/wiki/Building/Windows/SSHD> by Sam Hocevar <sam@hocevar.net>
#  Adapted from <https://gist.github.com/samhocevar/00eec26d9e9988d080ac> by David Macek
#
#  Prerequisites:
#    — a 64-bit installation of MSYS2 itself: https://msys2.org
#    — some packages: pacman -S openssh cygrunsrv mingw-w64-x86_64-editrights
#
#  Gotchas:
#    — the log file will be /var/log/msys2_sshd.log
#    — if you get error “sshd: fatal: seteuid XXX : No such device or address”
#      in the logs, try “passwd -R” (with admin privileges)
#    — if you get error “chown(/dev/pty1, XXX, YYY) failed: Invalid argument”
#      in the logs, make sure your account and group names are detectable (see
#      `id`); issues are often caused by having /etc/{passwd,group} or having
#      a modified /etc/nsswitch.conf
#
#  Changelog:
#   09 May 2020 — completely remove additional privileged user
#   16 Apr 2020 — remove additional privileged user
#               — only touch /etc/{passwd,group} if they exist
#   27 Jun 2019 — rename service to msys2_sshd to avoid conflicts with Windows OpenSSH
#               — use mkgroup.exe as suggested in the comments
#               — fix a problem with CRLF and grep
#   24 Aug 2015 — run server with -e to redirect logs to /var/log/sshd.log
#

## install dependencies : openssh ans cygrunsrv
pacman -S openssh cygrunsrv --noconfirm
## get editrights and install it
curl -O https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-editrights-1.03-3-any.pkg.tar.xz
pacman -U mingw-w64-x86_64-editrights-1.03-3-any.pkg.tar.xz --noconfirm


set -e

#
# Configuration
#

UNPRIV_USER=sshd # DO NOT CHANGE; this username is hardcoded in the openssh code
UNPRIV_NAME="Privilege separation user for sshd"

EMPTY_DIR=/var/empty


#
# Check installation sanity
#

if ! /mingw64/bin/editrights -h >/dev/null; then
    echo "ERROR: Missing 'editrights'. Try: pacman -S mingw-w64-x86_64-editrights."
    exit 1
fi

if ! cygrunsrv -v >/dev/null; then
    echo "ERROR: Missing 'cygrunsrv'. Try: pacman -S cygrunsrv."
    exit 1
fi

if ! ssh-keygen -A; then
    echo "ERROR: Missing 'ssh-keygen'. Try: pacman -S openssh."
    exit 1
fi


#
# The unprivileged sshd user (for privilege separation)
#

add="$(if ! net user "${UNPRIV_USER}" >/dev/null; then echo "//add"; fi)"
if ! net user "${UNPRIV_USER}" ${add} //fullname:"${UNPRIV_NAME}" \
              //homedir:"$(cygpath -w ${EMPTY_DIR})" //active:no; then
    echo "ERROR: Unable to create Windows user ${UNPRIV_USER}"
    exit 1
fi


#
# Add or update /etc/passwd entries
#

if test -f /etc/passwd; then
    sed -i -e '/^'"${UNPRIV_USER}"':/d' /etc/passwd
    SED='/^'"${UNPRIV_USER}"':/s?^\(\([^:]*:\)\{5\}\).*?\1'"${EMPTY_DIR}"':/bin/false?p'
    mkpasswd -l -u "${UNPRIV_USER}" | sed -e 's/^[^:]*+//' | sed -ne "${SED}" \
             >> /etc/passwd
    mkgroup.exe -l > /etc/group
fi


#
# Finally, register service with cygrunsrv and start it
#

cygrunsrv -R msys2_sshd || true
cygrunsrv -I msys2_sshd -d "MSYS2 sshd" -p /usr/bin/sshd.exe -a "-D -e" -y tcpip

# The SSH service should start automatically when Windows is rebooted. You can
# manually restart the service by running `net stop msys2_sshd` + `net start msys2_sshd`
if ! net start msys2_sshd; then
    echo "ERROR: Unable to start msys2_sshd service"
    exit 1
fi

# Force MSYS on ssh connection
cat <<"EOT" > .bashrc
if [ -n "$SSH_CONNECTION" ]; then
  export MSYSTEM=MSYS
  source /etc/profile
fi
EOT

# change sshd configuration
echo "Configuring sshd"
sed -i "s/#StrictModes yes/StrictModes no/" /etc/ssh/sshd_config
sed -i "s/#PermitUserEnvironment no/PermitUserEnvironment yes/" /etc/ssh/sshd_config
sed -i "s/#AllowAgentForwarding yes/AllowAgentForwarding yes/" /etc/ssh/sshd_config

# Add Vagrant ssh public key
echo "Configuring ssh private keys"
mkdir -p /c/Users/vagrant/.ssh
chmod 0700 /c/Users/vagrant/.ssh
curl -o /c/Users/vagrant/.ssh/id_rsa.pub https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub
cat /c/Users/vagrant/.ssh/id_rsa.pub >> /c/Users/vagrant/.ssh/authorized_keys
chmod 600 /c/Users/vagrant/.ssh/authorized_keys
chmod 644 /c/Users/vagrant/.ssh/id_rsa.pub
chown -R vagrant /c/Users/vagrant/.ssh


