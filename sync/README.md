# Claude Code 跨機同步說明

## iCloud 資料夾結構

```
iCloudDrive\Claude\
├── CLAUDE.md              ← 個人指令設定（主要版本）
├── sync\
│   ├── settings.json      ← Claude Code 權限與 Hook 設定
│   ├── mcp-servers.json   ← MCP Server 清單（含 API Key）
│   ├── memory\            ← AI 記憶備份
│   ├── sync-push.ps1      ← 推送：本機 → iCloud
│   ├── sync-pull.ps1      ← 拉取：iCloud → 本機
│   └── setup-new-machine.ps1  ← 新機器初始化腳本
└── 日誌\
    └── YYYY-MM\
        └── YYYY-MM-DD.md  ← 每日進度日誌
```

---

## 日常使用流程

### 本機 A 工作結束後 → 推送
```powershell
cd "$env:USERPROFILE\iCloudDrive\Claude\sync"
.\sync-push.ps1
```

### 換到本機 B 開始工作前 → 拉取
```powershell
cd "$env:USERPROFILE\iCloudDrive\Claude\sync"
.\sync-pull.ps1
```

---

## 新機器初始化步驟

1. 安裝 iCloud for Windows，等待同步完成
2. 安裝 Claude Code
3. 安裝 Node.js
4. 開啟 PowerShell，執行：
   ```powershell
   cd "$env:USERPROFILE\iCloudDrive\Claude\sync"
   .\setup-new-machine.ps1
   ```
5. 依提示重新設定 OAuth（Gmail、Google Calendar）
6. 重新啟動 Claude Code

---

## 同步項目對照表

| 項目 | 同步方式 | 備註 |
|------|----------|------|
| CLAUDE.md | ✅ 自動（iCloud） | 直接儲存在 iCloud |
| settings.json | ✅ 腳本同步 | 權限/Hook 設定 |
| Memory 記憶 | ✅ 腳本同步 | AI 跨對話記憶 |
| 每日日誌 | ✅ 自動（iCloud） | 直接儲存在 iCloud |
| Firecrawl API Key | ✅ mcp-servers.json | 兩台共用同一 Key |
| GitHub Token | ✅ mcp-servers.json | 兩台共用同一 Token |
| Gmail OAuth | ❌ 需各機授權 | Token 綁定機器 |
| Google Calendar OAuth | ❌ 需各機授權 | Token 綁定機器 |
