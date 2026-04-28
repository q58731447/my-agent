---
name: Heptabase MCP 設定進度
description: Heptabase MCP 連線設定狀態與待完成事項
type: project
originSessionId: 45080528-2c7c-4164-b06c-dd3fbf1cf3b4
---
Heptabase MCP 已透過 CLI 指令加入本地設定（2026.04.22）。

**設定資訊：**
- 指令：`claude mcp add --transport http heptabase-mcp https://api.heptabase.com/mcp`
- 寫入位置：`C:\Users\Jeff Chen\.claude.json`（project: C:\Users\Jeff Chen\iCloudDrive\Claude）
- 同時建立了 `C:\Users\Jeff Chen\iCloudDrive\Claude\.mcp.json`
- 驗證方式：Heptabase OAuth（需瀏覽器授權）

**Why:** 使用者目標是讓 Claude Code 自動把學習紀錄、書摘存入 Heptabase「學長AI系統」白板。

**How to apply:** 重啟 Claude Code 後確認 Heptabase MCP 工具是否出現，若有則立刻處理 Day 30 卡片存入作業。若 OAuth 尚未授權，引導使用者完成瀏覽器登入流程。
