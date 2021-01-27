# Install miktex for latex support
Write-Output "Installing MiKTeX"

#### Now done in tasks ####
## install from basic ##
#Write-Output "Downloading installer"
#$url = "https://miktex.org/download/ctan/systems/win32/miktex/setup/windows-x64/basic-miktex-20.11-x64.exe"
#$output = "C:\Windows\Temp\miktex.exe"
#$wcR = New-Object System.Net.WebClient

#Write-Output "Downloading $url"
#Download the zip
#$wcR.DownloadFile($url, $output)
#Write-Output "Download completed $url"
####


C:\Windows\Temp\miktex.exe --auto-install=yes --common-install=C:\miktex --shared --unattended | Out-Null

## Network install with local repository ##
#Write-Output "Downloading installer"
## download last relase name
#$url = "https://miktex.org/download/win/miktexsetup-x64.zip"
#$output = 'c:\Windows\Temp\miktex.zip'
#$wcR = New-Object System.Net.WebClient

#Write-Output "Downloading $url"
##Download the zip
#$wcR.DownloadFile($url, $output)
#Write-Output "Download completed $url"

#Write-Output "unzip"
#Expand-Archive -LiteralPath $output -DestinationPath 'C:\Windows\Temp\' -Force

#Write-Output "Download repository"
#C:\Windows\Temp\miktexsetup.exe --verbose --local-package-repository=C:\Windows\Temp\miktex --package-set=complete download
#Write-Output "Download repository again in case of trouble"
#C:\Windows\Temp\miktexsetup.exe --verbose --local-package-repository=C:\Windows\Temp\miktex --package-set=complete download

#Write-Output "Install "
#C:\Windows\Temp\miktexsetup.exe --quiet --local-package-repository=C:\Windows\Temp\miktex --package-set=basic --shared=no --common-install='C:\miktex' install

#Write-Output "MiKTeX installed into C:\miktex"
#Remove-Item 'C:\Windows\Temp\miktexsetup.exe' -Force
# enable auto install
#Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\MiKTeX.org\MiKTeX\2.9\MPM' -Name AutoInstall -Value 1
#Remove-Item 'C:\windows\Temp\miktex' -Recurse

if ( Test-Path "HKLM:\SOFTWARE\MiKTeX.org\MiKTeX" ) {
	Write-Output "MiKTeX installed"
}
else {
	throw "ERROR: Can't install MiKTeX"
}

Remove-Item $output -Force

