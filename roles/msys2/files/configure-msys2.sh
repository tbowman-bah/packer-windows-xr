#!/bin/sh

## execute using bash C:\Rtools\usr\bin\bash.exe

# Add repository
sed -i.bak -e "s/^#\[msys\]/\[msys\]/" -e "s/^#Include/Include/" /etc/pacman.conf
#echo -e "Server = http://repo.msys2.org/mingw/\$arch/" >> /etc/pacman.d/mirrorlist.msys
#echo -e "Server = http://repo.msys2.org/mingw/x86_64/" >> /etc/pacman.d/mirrorlist.mingw64

# Update server gpg key
curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz
curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig
pacman-key --verify msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig
pacman --noconfirm -U --config <(echo) msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz
pacman -U msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz --noconfirm

# Update msys2 (just one time to keep Rtools dependences versions)
pacman -Syy --noconfirm

#pacman -S openssh cygrunsrv mingw-w64-x86_64-editrights --noconfirm
