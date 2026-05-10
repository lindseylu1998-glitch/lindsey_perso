$ErrorActionPreference = 'Continue'
$rclone = (Get-Command rclone -ErrorAction SilentlyContinue).Source
if (-not $rclone) { $rclone = "C:\Users\lindsey.johnson\rclone\rclone-v1.74.1-windows-amd64\rclone.exe" }
$dst = "$env:USERPROFILE\.claude\projects\C--Users-lindsey-johnson"
$src = "gdrive:lindsey_perso_claude"
if (Test-Path $rclone) { & $rclone copy $src $dst --create-empty-src-dirs *>$null }
exit 0
