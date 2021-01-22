# Install miktex for latex support
Write-Output "Installing pandoc"

Write-Output "Downloading installer"
## download 
$url = "https://github.com/jgm/pandoc/releases/download/2.10.1/pandoc-2.10.1-windows-x86_64.zip"
$output = 'c:\Windows\Temp\pandoc.zip'
$wcR = New-Object System.Net.WebClient

Write-Output "Downloading $url"
#Download the exe
$wcR.DownloadFile($url, $output)
Write-Output "Download completed $url"

$pandocDir = 'C:\pandoc\'
Write-Output "Install $output into $pandocDir"
Expand-Archive -LiteralPath $output -DestinationPath $pandocDir -Force

if (Test-Path 'C:\pandoc\pandoc-2.10.1\pandoc.exe')
{
	Write-Output "pandoc installed"
}
else
{
	throw "ERROR: Can't install pandoc"
}
# Add pandoc to PATH
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newPath = "$oldpath;C:\pandoc\pandoc-2.10.1\\"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
Remove-Item $output -Force
