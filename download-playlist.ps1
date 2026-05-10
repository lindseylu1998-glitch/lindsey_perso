param(
    [Parameter(Mandatory = $true)][string]$Url,
    [string]$DriveFolder = "Sandbox/guessann-oka-sandbox"
)

$ErrorActionPreference = 'Stop'

$ytdlp = (Get-Command yt-dlp -ErrorAction SilentlyContinue).Source
if (-not $ytdlp) { $ytdlp = "C:\Users\lindsey.johnson\bin\yt-dlp.exe" }

$rclone = (Get-Command rclone -ErrorAction SilentlyContinue).Source
if (-not $rclone) { $rclone = "C:\Users\lindsey.johnson\rclone\rclone-v1.74.1-windows-amd64\rclone.exe" }

$tmp = Join-Path $env:TEMP "ytdlp-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
New-Item -ItemType Directory -Path $tmp -Force | Out-Null

Write-Host "Downloading to $tmp"
& $ytdlp --ignore-errors -o "$tmp\%(playlist_index)02d - %(title)s.%(ext)s" $Url

$files = Get-ChildItem $tmp -File -ErrorAction SilentlyContinue
if (-not $files) { Write-Error "Nothing downloaded to $tmp"; exit 1 }
"Got $($files.Count) file(s); uploading to gdrive:$DriveFolder"

& $rclone copy $tmp "gdrive:$DriveFolder" --progress
if ($LASTEXITCODE -ne 0) { Write-Error "rclone copy failed"; exit 1 }

Remove-Item $tmp -Recurse -Force

Write-Host ""
Write-Host "Done. Shareable Drive link:"
& $rclone link "gdrive:$DriveFolder"
