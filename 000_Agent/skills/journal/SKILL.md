---
name: journal
description: 每日學習日誌存入 SOP — 收到格式為「學習紀錄 | YYYY.MM.DD Day XX」的日誌內容後，直接存入 Heptabase，並詢問是否草擬 Threads 貼文。當使用者說「學習日誌」「日誌模式」「存日誌」「/journal」，或貼入含有「學習紀錄 | Day」字樣的內容時，務必使用此 skill。不需要走 knowledge-card 流程，直接存入。
---

# 每日學習日誌 SOP

## 步驟零：判斷來源（自動讀取 or 直接貼入）

### 情況 A：使用者沒有貼入任何日誌內容

觸發條件：使用者說「學習日誌」「存日誌」「日誌模式」「/journal」，但**沒有附上任何文字內容**。

執行步驟：

1. 詢問：
   ```
   要讀取哪一天的 Journal？（直接回覆日期，例如 2026-06-01，或說「今天」）
   ```

2. 收到日期後，呼叫 `get_journal_range`，startDate 與 endDate 皆設為該日期（格式 YYYY-MM-DD）。

3. 從回傳內容中，擷取「學習紀錄 |」開始、「學習紀錄結束」結束之間的所有文字（含首尾標記行）。

4. 若找不到學習紀錄區塊，告知使用者：
   ```
   ⚠️ 該日 Journal 中找不到學習紀錄區塊（需包含「學習紀錄 |」與「學習紀錄結束」標記）。
   ```
   然後停止流程。

5. 擷取成功後，將內容帶入**步驟一**繼續執行。

### 情況 B：使用者直接貼入日誌內容

觸發條件：使用者貼入含有「學習紀錄 | YYYY.MM.DD Day XX」格式的文字。

直接進入**步驟一**，不詢問、不確認。

---

## 步驟一：接收日誌內容

收到日誌內容後，**不詢問、不確認**，直接進入步驟二。

日誌識別特徵：
- 標題行格式：`學習紀錄 | YYYY.MM.DD Day XX`
- 或使用者明確說「學習日誌」「存日誌」「日誌模式」

---

## 步驟二：存入 Heptabase

> ⚠️ **必須使用 `save_to_note_card`（新增卡片），絕對不可使用 `append_to_journal`（存入日誌）。**

呼叫 `save_to_note_card`，依以下規則處理內容：

### 保留原文不得修改的區塊

1. **標題行**：`學習紀錄 | YYYY.MM.DD Day XX`（完整原文，一字不改）
2. **🎯 今天目標區塊**：包含所有條目與完成符號，原文照貼，不重新排版

> 這兩個區塊是使用者的原始紀錄，有固定格式與語意，任何改動都會破壞一致性。

### 可整理加工的區塊

其餘區塊（如實作結果、反思、下一步、Claude 對話摘要等）可適當整理格式，但不改變內容語意。

### 卡片標題格式

```
學習紀錄 | YYYY.MM.DD Day XX
```

與標題行相同，直接使用。

存入後告知使用者：「✅ 已存入 Heptabase：學習紀錄 | YYYY.MM.DD Day XX」

---

## 步驟三：產出 HTML 視覺報告

根據步驟一的日誌內容，產出以下 HTML，並用 Write 工具存檔至：

```
C:\Users\Jeff Chen\iCloudDrive\Claude\my-agent\html-demo\journal-YYYYMMDD.html
```

（YYYYMMDD 替換為當日日期）

### 解析日誌欄位

從日誌內容中擷取：

- **日期**：YYYY.MM.DD
- **Day 數**：Day XX
- **今天目標**：逐條列出，判斷每條是否含 ✅（達成）、❌（未達成）、或其他符號
- **目標達成數**：統計 ✅ 數量 / 總條數
- **實作內容**（若有）：取前 100 字
- **反思**（若有）：取前 100 字
- **下一步**（若有）：取前 100 字

### HTML 模板

將所有 `{{變數}}` 替換為實際資料後存檔：

```html
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<style>
  body {
    font-family: "Noto Sans TC", sans-serif;
    background: #0f0f0f;
    color: #e0e0e0;
    padding: 24px;
    max-width: 640px;
    margin: auto;
  }
  .header { text-align: center; margin-bottom: 24px; }
  .header .day { font-size: 2rem; font-weight: bold; color: #f5c842; line-height: 1; }
  .header .date { color: #888; font-size: 0.85rem; margin-top: 6px; }
  .card { background: #1a1a1a; border-radius: 12px; padding: 16px 20px; margin-bottom: 16px; }
  .card-title { font-size: 0.75rem; color: #888; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; }
  .goal-item { display: flex; align-items: flex-start; gap: 10px; font-size: 0.85rem; padding: 6px 0; border-bottom: 1px solid #2a2a2a; }
  .goal-item:last-child { border-bottom: none; }
  .goal-icon { flex-shrink: 0; font-size: 1rem; }
  .goal-text { flex: 1; line-height: 1.5; }
  .progress-bar { margin-top: 12px; }
  .progress-label { display: flex; justify-content: space-between; font-size: 0.78rem; margin-bottom: 4px; }
  .progress-track { background: #2a2a2a; border-radius: 99px; height: 8px; overflow: hidden; }
  .progress-fill { height: 100%; border-radius: 99px; background: linear-gradient(90deg, #f5c842, #4cde80); }
  .section { margin-bottom: 10px; }
  .section-label { font-size: 0.72rem; color: #f5c842; margin-bottom: 4px; letter-spacing: 0.5px; }
  .section-content { font-size: 0.83rem; line-height: 1.7; color: #ccc; }
  .tag-row { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 4px; }
  .tag { background: #2a2a2a; border-radius: 6px; padding: 3px 10px; font-size: 0.75rem; color: #aaa; }
</style>
</head>
<body>

<div class="header">
  <div class="day">{{Day數}}</div>
  <div class="date">學習紀錄｜{{YYYY.MM.DD}}</div>
</div>

<div class="card">
  <div class="card-title">今天目標</div>
  {{目標列表HTML}}
  <div class="progress-bar">
    <div class="progress-label"><span>目標達成</span><span>{{達成數}} / {{總數}}</span></div>
    <div class="progress-track"><div class="progress-fill" style="width:{{達成百分比}}%"></div></div>
  </div>
</div>

<div class="card">
  <div class="card-title">今日紀錄</div>
  <div class="section">
    <div class="section-label">▸ 實作內容</div>
    <div class="section-content">{{實作內容}}</div>
  </div>
  <div class="section">
    <div class="section-label">▸ 反思</div>
    <div class="section-content">{{反思}}</div>
  </div>
  <div class="section">
    <div class="section-label">▸ 下一步</div>
    <div class="section-content">{{下一步}}</div>
  </div>
</div>

</body>
</html>
```

### 變數說明

| 變數 | 填入規則 |
|------|---------|
| `{{Day數}}` | 如 `Day 30` |
| `{{YYYY.MM.DD}}` | 如 `2026.05.15` |
| `{{目標列表HTML}}` | 每條目標產出一個 `<div class="goal-item"><span class="goal-icon">符號</span><span class="goal-text">內容</span></div>`；符號直接取原文（✅ / ❌ / 🔄 等） |
| `{{達成數}}` | 含 ✅ 的條目數 |
| `{{總數}}` | 目標總條數 |
| `{{達成百分比}}` | `達成數 / 總數 × 100`，取整數 |
| `{{實作內容}}` | 原文擷取，無則填「——」 |
| `{{反思}}` | 原文擷取，無則填「——」 |
| `{{下一步}}` | 原文擷取，無則填「——」 |

存檔完成後告知使用者：

```
📄 HTML 報告已產出：journal-YYYYMMDD.html
路徑：C:\Users\Jeff Chen\iCloudDrive\Claude\my-agent\html-demo\
用瀏覽器開啟後，按 F12 → Ctrl+Shift+P → 輸入 screenshot → 選「Capture full size screenshot」即可存成圖片。
```

---

## 步驟四：詢問 Threads 貼文

存入完成後，詢問：

```
要幫你草擬這篇日誌的 Threads 貼文嗎？
```

若使用者回覆「要」或「草擬」，則依以下規則產出貼文：

### 固定開頭（每次都必須包含，原文照貼）

```
學習紀錄 | YYYY.MM.DD Day XX
🎯 今天目標：
•任務一（完成符號）
•任務二（完成符號）
```

### 內文規則

- **全篇總字數（含固定開頭）控制在 200 字以內**
- 以當天最有收穫或最有感的事為核心
- 開頭第一句（固定開頭之後）需能吸引人繼續閱讀
- **手機閱讀優先**：每句話單獨一行，每個概念段落之間空一行
- 每個段落不超過 2～3 行，避免大段文字擠在一起
- 語氣：個人成長 + 系統思維，親切不說教
- 不加 hashtag
- 結尾可加一句反思或行動呼籲

---

## 步驟五：確認並發佈 Threads

草擬完成後，輸出貼文內容，並詢問：

```
以上是 Threads 貼文草稿，可以發佈嗎？
```

使用者確認後，呼叫 `mcp__meta__threads_publish_text` 發佈到 **@thisisj587**。

發佈完成後告知：「✅ Threads 貼文已發佈至 @thisisj587！」
