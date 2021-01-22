# Install R 
Write-Output "Installing R"

Write-Output "Downloading R Last Version"
## Download R engine for Windows machine

## download last relase name
$urlR = "https://cran.biotools.fr/bin/windows/base/release.html"
$outputR = 'c:\Windows\Temp\R-win.exe'
$wcR = New-Object System.Net.WebClient
$res = $wcR.DownloadString($urlR)

## get release name in the HTML page
$pos1 = $res.IndexOf("URL=")
$pos2 = $res.LastIndexOf('"')
$Rexe = $res.Substring($pos1+4, $pos2-$pos1-4)
$urlR = "https://cran.biotools.fr/bin/windows/base/" + $Rexe

Write-Output "Downloading $($urlR)"
#Download the exe
$wcR.DownloadFile($urlR, $outputR)

Write-Output "Download completed $Rexe"

$RDir = 'C:\R\'
Write-Output "Install $outputR into $RDir"
Start-Process -FilePath $outputR -ArgumentList "/VERYSILENT /DIR=$RDir" -Wait -NoNewWindow

if ( Test-Path "HKLM:\Software\R-core\R" ) {
	$Rver = (Get-ItemProperty -Path "HKLM:\Software\R-core\R")."Current Version"
	Write-Output "R version $($Rver) installed"
}
else {
	throw "ERROR: Can't install R $($urlR)"
}

# Add R to PATH
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newPath = "$oldpath;C:\R\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
Remove-Item $outputR -Force

# configure LANG
$renv = "C:\Users\vagrant\.Renviron"
New-Item -Path $renv -ItemType File
Add-Content -Path $renv -Value 'LC_COLLATE  = "French_France.1252"'
Add-Content -Path $renv -Value 'LC_CTYPE    = "French_France.1252"'
Add-Content -Path $renv -Value 'LC_MONETARY = "French_France.1252"'
Add-Content -Path $renv -Value 'LC_NUMERIC  = "French_France.1252"'
Add-Content -Path $renv -Value 'LC_TIME     = "French_France.1252"'

