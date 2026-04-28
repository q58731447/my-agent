# setup-new-machine.ps1 — 新筆電初始化設定
# 使用方式：iCloud 同步完成後，在新機器 PowerShell 執行此腳本

param(
    [string]$Username = $env:USERNAME
)

$iCloud = "$env:USERPROFILE\iCloudDrive\Claude"
$claudeDir = "$env:USERPROFILE\.claude"

Write-Host "=== Claude Code 新機器初始化 ===" -ForegroundColor Cyan
Write-Host "使用者：$Username"
Write-Host ""

# 步驟 1: 建立必要資料夾
Write-Host "[1/5] 建立資料夾..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "$env:USERPROFILE\Documents\Claude" -Force | Out-Null
New-Item -ItemType Directory -Path "$claudeDir\projects\C--Users-$Username-Documents-Claude\memory" -Force | Out-Null
Write-Host "  ✅ 完成"

# 步驟 2: 複製 settings.json
Write-Host "[2/5] 複製 Claude 設定..." -ForegroundColor Yellow
Copy-Item "$iCloud\sync\settings.json" "$claudeDir\settings.json" -Force
Write-Host "  ✅ settings.json"

# 步驟 3: 複製 Memory
Write-Host "[3/5] 複製記憶資料..." -ForegroundColor Yellow
$memSrc = "$iCloud\sync\memory"
$memDst = "$claudeDir\projects\C--Users-$Username-Documents-Claude\memory"
if (Test-Path $memSrc) {
    Copy-Item "$memSrc\*" $memDst -Recurse -Force
    Write-Host "  ✅ memory 記憶"
}

# 步驟 4: 複製 CLAUDE.md
Write-Host "[4/5] 複製 CLAUDE.md..." -ForegroundColor Yellow
Copy-Item "$iCloud\CLAUDE.md" "$env:USERPROFILE\Documents\Claude\CLAUDE.md" -Force
Write-Host "  ✅ CLAUDE.md"

# 步驟 5: 提示 MCP 設定
Write-Host "[5/5] MCP 設定提醒..." -ForegroundColor Yellow
Write-Host ""
Write-Host "  ⚠️  以下 MCP 需在新機器手動設定：" -ForegroundColor Yellow
Write-Host "  📄 參考：$iCloud\sync\mcp-servers.json"
Write-Host ""
Write-Host "  需要重新授權（OAuth）："
Write-Host "    - Gmail：執行 npx @gongrzhe/server-gmail-autoauth-mcp 觸發授權"
Write-Host "    - Google Calendar：確認 credentials.json 路徑"
Write-Host ""
Write-Host "  直接可用（API Key）："
Write-Host "    - Firecrawl ✅（Key 在 mcp-servers.json）"
Write-Host "    - GitHub ✅（Token 在 mcp-servers.json）"
Write-Host "    - Filesystem ✅（調整路徑後可用）"
Write-Host "    - Playwright ✅"
Write-Host "    - Heptabase ✅"

Write-Host ""
Write-Host "=== 初始化完成！重新啟動 Claude Code 生效 ===" -ForegroundColor Green
