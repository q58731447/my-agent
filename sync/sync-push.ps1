# sync-push.ps1 — 本機 → iCloud（儲存進度）
# 使用方式：在 PowerShell 執行 .\sync-push.ps1

$iCloud = "$env:USERPROFILE\iCloudDrive\Claude"
$claudeDir = "$env:USERPROFILE\.claude"

Write-Host "推送設定到 iCloud..." -ForegroundColor Cyan

# 1. settings.json
Copy-Item "$claudeDir\settings.json" "$iCloud\sync\settings.json" -Force
Write-Host "  ✅ settings.json"

# 2. Memory 記憶
$memSrc = "$claudeDir\projects\C--Users-$env:USERNAME-Documents-Claude\memory"
$memDst = "$iCloud\sync\memory"
if (Test-Path $memSrc) {
    if (-not (Test-Path $memDst)) { New-Item -ItemType Directory -Path $memDst | Out-Null }
    Copy-Item "$memSrc\*" $memDst -Recurse -Force
    Write-Host "  ✅ memory 記憶"
} else {
    Write-Host "  ⚠️  memory 資料夾不存在：$memSrc"
}

# 3. CLAUDE.md
Copy-Item "$env:USERPROFILE\Documents\Claude\CLAUDE.md" "$iCloud\CLAUDE.md" -Force
Write-Host "  ✅ CLAUDE.md"

Write-Host ""
Write-Host "推送完成！$(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor Green
