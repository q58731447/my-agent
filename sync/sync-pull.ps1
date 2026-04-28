# sync-pull.ps1 — iCloud → 本機（還原設定）
# 使用方式：在 PowerShell 執行 .\sync-pull.ps1

$iCloud = "$env:USERPROFILE\iCloudDrive\Claude"
$claudeDir = "$env:USERPROFILE\.claude"

Write-Host "從 iCloud 拉取設定..." -ForegroundColor Cyan

# 1. settings.json
Copy-Item "$iCloud\sync\settings.json" "$claudeDir\settings.json" -Force
Write-Host "  ✅ settings.json"

# 2. Memory 記憶
$memSrc = "$iCloud\sync\memory"
$memDst = "$claudeDir\projects\C--Users-$env:USERNAME-Documents-Claude\memory"
if (Test-Path $memSrc) {
    if (-not (Test-Path $memDst)) { New-Item -ItemType Directory -Path $memDst -Force | Out-Null }
    Copy-Item "$memSrc\*" $memDst -Recurse -Force
    Write-Host "  ✅ memory 記憶"
}

# 3. CLAUDE.md
$docPath = "$env:USERPROFILE\Documents\Claude"
if (-not (Test-Path $docPath)) { New-Item -ItemType Directory -Path $docPath | Out-Null }
Copy-Item "$iCloud\CLAUDE.md" "$docPath\CLAUDE.md" -Force
Write-Host "  ✅ CLAUDE.md"

Write-Host ""
Write-Host "拉取完成！$(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  提醒：MCP 設定需手動設定（請參考 mcp-servers.json）" -ForegroundColor Yellow
