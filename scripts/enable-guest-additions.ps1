Start-Transcript -Verbose

$isoname = "C:\Windows\Temp\VBoxGuestAdditions.iso"

Write-Output "Mounting disk image at $isoname"
Mount-DiskImage -ImagePath $isoname

$certdir = ((Get-DiskImage -ImagePath $isoname | Get-Volume).Driveletter + ':\cert\')
$VBoxCertUtil = ($certdir + 'VBoxCertUtil.exe')
if (Test-Path ($VBoxCertUtil)) {
  Write-Output "Certificate import"
	Get-ChildItem $certdir *.cer | ForEach-Object { & $VBoxCertUtil add-trusted-publisher $_.FullName --root $_.FullName}
}

Write-Output "Start VBoxWindowsAdditions install"
$exe = ((Get-DiskImage -ImagePath $isoname | Get-Volume).Driveletter + ':\VBoxWindowsAdditions.exe')
$parameters = "/S"

Start-Process -FilePath $exe -ArgumentList $parameters -Wait -NoNewWindow

if (!(Test-Path 'C:\Program Files\Oracle\VirtualBox Guest Additions')) {throw "ERROR: VBox Guest Additions install failed"}
else { Write-Output "VBox Guest Additions installed" }

Write-Output "Dismounting disk image $isoname"
Dismount-DiskImage -ImagePath $isoname
Write-Output "Deleting $isoname"
Remove-Item $isoname -Recurse -Force

Stop-Transcript -Verbose
