# Install Gitlab runner
Write-Output "Installing GitLab Runners"

Write-Output "Downloading Gitlab Runners Last Version"
## download last relase name
$url = "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-windows-amd64.exe"
$output = 'C:\GitLab-Runner\gitlab-runner.exe'
if ( -Not (Test-Path -Path 'C:\GitLab-Runner')) {
	New-Item -Path 'c:\' -Name "GitLab-Runner" -ItemType "directory"
}
$wcR = New-Object System.Net.WebClient

Write-Output "Downloading $url"
#Download the exe
$wcR.DownloadFile($url, $output)
Write-Output "Download completed $url"

# Add GitLab to PATH
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newPath = "$oldpath;C:\GitLab-Runner\\"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath


