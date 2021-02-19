# Install R Tools 4.0
Write-Output "Installing Rtools 4.0"

Write-Output "Downloading Rtools Last Version"
## download last relase name
$urlRtools = "https://cran.biotools.fr/bin/windows/Rtools/rtools40-x86_64.exe"
$outputRtools = 'c:\Windows\Temp\Rtools-win.exe'
$wcR = New-Object System.Net.WebClient

Write-Output "Downloading $urlRtools"
#Download the exe
$wcR.DownloadFile($urlRtools, $outputRtools)
Write-Output "Download completed $urlRtools"

$RtoolsDir = 'C:\Rtools\'
Write-Output "Install $outputRtools into $RtoolsDir"
Start-Process -FilePath $outputRtools -ArgumentList "/VERYSILENT /DIR=$RtoolsDir" -Wait -NoNewWindow

if ( Test-Path "HKLM:\Software\R-core\Rtools" ) {
	$Rtoolsver = (Get-ItemProperty -Path "HKLM:\Software\R-core\Rtools")."Current Version"
	Write-Output "Rtools version $Rtoolsver installed"
}
else {
	throw "ERROR: Can't install R $urlRtools"
}

# Add R to PATH
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newPath = "$oldpath;C:\Rtools\usr\bin;C:\Rtools\mingw64\bin;C:\Rtools\mingw32\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
[System.Environment]::SetEnvironmentVariable('MSYS2_PATH_TYPE', 'inherit', [System.EnvironmentVariableTarget]::Machine)
Add-Content C:\Rtools\msys2.ini "MSYS2_PATH_TYPE=inherit"
Remove-Item $outputRtools -Force
