param([switch]$DryRun)

$rclone = "C:\Users\lindsey.johnson\rclone\rclone-v1.74.1-windows-amd64\rclone.exe"
$src = "$env:USERPROFILE\.claude\projects\C--Users-lindsey-johnson"
$dst = "gdrive:lindsey_perso_claude"

$args = @("sync", $src, $dst, "--progress", "--create-empty-src-dirs")
if ($DryRun) { $args += "--dry-run" }

& $rclone @args
