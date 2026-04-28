---
name: GitHub 同步排除規則
description: 含 API Key 的檔案一律不推上 GitHub
type: feedback
originSessionId: e92a3157-89b5-43f5-bf5b-7175779e5a1f
---
任何包含 API Key 或 Token 的檔案，不得 commit 或推送到 GitHub。

**Why:** 避免 Threads、Cloudflare 等服務的 API Key 外洩。

**How to apply:** 遇到含 API Key 的檔案（如 settings.local.json、.env、token 相關檔案），確認已加入 .gitignore，並從 staging area 移除，不得 commit 進 repo。
