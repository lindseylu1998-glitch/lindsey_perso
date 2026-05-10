$ErrorActionPreference = 'Continue'
$rclone = (Get-Command rclone -ErrorAction SilentlyContinue).Source
if (-not $rclone) { $rclone = "C:\Users\lindsey.johnson\rclone\rclone-v1.74.1-windows-amd64\rclone.exe" }
$src = "$env:USERPROFILE\.claude\projects\C--Users-lindsey-johnson"
$dst = "gdrive:lindsey_perso_claude"
if (Test-Path $rclone) { & $rclone sync $src $dst --create-empty-src-dirs *>$null }
exit 0
