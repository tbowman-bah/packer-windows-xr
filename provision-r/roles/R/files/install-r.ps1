# Install R 
Write-Output "Installing R"

#### this is done in tasks now ####
#Write-Output "Downloading R Last Version"
## Download R engine for Windows machine

## download last relase name
#$urlR = "https://cran.biotools.fr/bin/windows/base/release.html"
#$outputR = 'c:\Windows\Temp\R-win.exe'
#$wcR = New-Object System.Net.WebClient
#$res = $wcR.DownloadString($urlR)

## get release name in the HTML page
#$pos1 = $res.IndexOf("URL=")
#$pos2 = $res.LastIndexOf('"')
#$Rexe = $res.Substring($pos1+4, $pos2-$pos1-4)
#$urlR = "https://cran.biotools.fr/bin/windows/base/" + $Rexe

#Write-Output "Downloading $($urlR)"
#Download the exe
#$wcR.DownloadFile($urlR, $outputR)

#Write-Output "Download completed $Rexe"
####

$outputR = 'c:\Windows\Temp\R-win.exe'
$RDir = 'C:\R\'
Write-Output "Install $outputR into $RDir"
Start-Process -FilePath $outputR -ArgumentList "/VERYSILENT /DIR=$RDir" -Wait -NoNewWindow

if ( Test-Path "HKLM:\Software\R-core\R" ) {
	$Rver = (Get-ItemProperty -Path "HKLM:\Software\R-core\R")."Current Version"
	Write-Output "R version $($Rver) installed"
}
else {
	throw "ERROR: Can't install R "
}

# Add R to PATH
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newPath = "$oldpath;C:\R\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
Remove-Item $outputR -Force

