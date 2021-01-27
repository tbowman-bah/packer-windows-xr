$pandocversion=$args[0]

# Install miktex for latex support
Write-Output "Installing pandoc"

#### Done in tasks now
#Write-Output "Downloading installer"
## download 
#$url = "https://github.com/jgm/pandoc/releases/download/2.10.1/pandoc-2.10.1-windows-x86_64.zip"
#$output = 'c:\Windows\Temp\pandoc.zip'
#$wcR = New-Object System.Net.WebClient

#Write-Output "Downloading $url"
#Download the exe
#$wcR.DownloadFile($url, $output)
#Write-Output "Download completed $url"

#$pandocDir = 'C:\pandoc\'
#Write-Output "Install $output into $pandocDir"
#Expand-Archive -LiteralPath $output -DestinationPath $pandocDir -Force

$pandocDir="C:\\pandoc"
Write-Output "Install into $pandocDir"
msiexec /i c:\Windows\Temp\pandoc.msi APPLICATIONFOLDER="$pandocDir" ALLUSERS=1 /qn
Start-Sleep -Seconds 3

if (Test-Path "$pandocDir\\pandoc.exe")
{
	Write-Output "pandoc installed"
}
else
{
	throw "ERROR: Can't install pandoc"
}
# Add pandoc to PATH
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newPath = "$oldpath;$pandocDir"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
Remove-Item $output -Force
