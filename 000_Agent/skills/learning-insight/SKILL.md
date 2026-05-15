---
name: learning-insight
description: 學習心得內容編輯 SOP — 收到使用者的學習心得文字後，依序產出金句 10 則、關鍵字 10 個、轉單文案 10 句、Threads 貼文（250 字去 AI 化版本）。當使用者說「學習心得」「心得模式」「/learning-insight」，或貼入含有「【我的心得】」字樣的內容時，務必使用此 skill。
---

# 學習心得內容編輯 SOP

## 步驟一：接收心得內容

收到心得文字後，**不詢問、不確認**，直接進入步驟二。

識別特徵：
- 使用者說「學習心得」「心得模式」「/learning-insight」
- 貼入含有「【我的心得】」字樣的文字
- 貼入一段完整的學習反思或課程心得文字

---

## 步驟二：依序完成四個任務

你是一位專業的社群內容編輯，擅長將深度內容濃縮成適合 Threads 發布的貼文。

輸入素材：**使用者提供的學習心得文字**

輸出請依序呈現任務一、任務二、任務三、任務四，每個任務前標示標題，任務之間空一行區隔。

---

### 任務一：金句 10 則

**要求：**
- 語言：繁體中文
- 每句不超過 15 個字
- 語感精準有力，適合單獨截圖或引用
- 融合原始內容的洞見與心得角度
- 10 句需涵蓋不同面向，避免重複相近概念
- 格式：
  ```
  1. 句子
  2. 句子
  ……依序排列
  ```

---

### 任務二：關鍵字 10 個

**要求：**
- 語言：繁體中文
- 關鍵字只能從心得文字中提取
- 以單詞或短詞為主（2～5 字為佳）
- 格式：
  ```
  # 關鍵字（每個獨立一行）
  ```

---

### 任務三：轉單文案 10 句

依照以下「10 大轉單密碼」，每個密碼對應產出一句 Threads 文案：

1. 獨家賣點
2. 急迫性／稀缺性
3. 談「錢」
4. 掛保證
5. 立權威
6. 成功見證
7. 踩痛點
8. 貼標籤
9. 給利益
10. 隱藏的第二標題：PS

**要求：**
- 素材來自使用者心得
- 每一句的重點是用內容本身的共鳴感抓住讀者眼球，讓人產生「現在就想繼續看」的衝動
- 不使用銷售語氣，不製造促銷壓迫感，避免出現「限時」「立刻購買」「馬上行動」等促銷用語
- 每句標註對應的密碼編號與名稱
- 語言：繁體中文
- 每句不超過 20 字
- 格式：
  ```
  1. 【獨家賣點】文案內容
  2. 【急迫性／稀缺性】文案內容
  ……依序排列
  ```

---

### 任務四：Threads 貼文（約 250 字，去 AI 化版本）

你是一位熟悉台灣網路閱讀習慣的內容編輯，擅長將長篇學習心得改寫成適合 Threads 平台的短文。

**平台特性（Threads）**
- 讀者習慣快速滑動，前兩行決定是否繼續讀
- 段落短、空行多，視覺上容易呼吸
- 台灣繁體中文用語，口語自然，不過度正式
- 偏個人感受與真實經歷的敘事角度

**內容結構**
1. 開頭：用一句話勾住讀者（問句、反常識觀點、或具體場景）
2. 中段：提煉核心學習洞察，保留 1-2 個最有感的細節或例子
3. 結尾：一句有餘韻的個人感悟，不說教

**去 AI 化潤色原則**
- 使用自然、流暢有節奏感的繁體中文，模仿資深作者或記者筆觸
- 避免「首先、其次、最後」「總之」「綜上所述」「應該注意的是」等機械式連接詞
- 將被動語態轉為主動語態，長短句交錯
- 在合適位置加入適度個人見解、場景化描述或具象比喻（避免老套比喻）
- 打破「總分總」或「並列式」模板結構，讓段落銜接自然過渡
- 可插入少量口語插入語（如「說起來」「實際上」），或限定詞（如「在多數情況下」「或許」），使文字更像真人思考過程
- 避免完美主義：可輕微調整論點，使其像個人觀點而非絕對真理
- 替換「值得注意的是」「毫無疑問」「一般來說」等 AI 高頻詞彙
- 使用具體、生動的動詞和名詞，減少抽象詞彙
- 可隨機將部分陳述句改為反問句或設問句，增強互動感

**格式規範**
- 全文約 250 字（可 ±20 字）
- 段落之間留空行
- 不加 hashtag
- 直接輸出內文，不加任何說明語

---

## 步驟三：詢問卡片資訊

四個任務完成後，依序詢問以下四個問題（**一次全部問，不分開問**）：

```
請回答以下四個問題，我來幫你建立 Heptabase 卡片：

1. 這個心得是「觀念」還是「方法」？
2. 心得的來源是什麼？（書名、課程名、影片名等）
3. 原始作者是誰？
4. 這份心得的主旨（一句話概括）？
```

---

## 步驟四：產生卡片標題並存入 Heptabase

收到四個答案後，依規則產生卡片標題：

| 類型 | 標題格式 |
|------|------|
| 觀念 | `[C][來源][作者][主旨]` |
| 方法 | `[M][來源][作者][主旨]` |

**存入卡片的內容（依序）：**

1. 使用者提供的原始心得文字
2. 任務一：金句 10 則
3. 任務二：關鍵字 10 個
4. 任務三：轉單文案 10 句
5. 任務四：Threads 貼文

呼叫 `save_to_note_card`，卡片第一行為產生的標題（作為卡片 title）。

存入後告知使用者：「✅ 已存入 Heptabase：[卡片標題]」

---

## 步驟五：產出 HTML 視覺報告

根據步驟二的四個任務輸出，用 Write 工具存檔至：

```
C:\Users\Jeff Chen\iCloudDrive\Claude\my-agent\html-demo\learning-insight-YYYYMMDD.html
```

（YYYYMMDD 替換為當日日期）

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
    max-width: 680px;
    margin: auto;
  }
  .header { text-align: center; margin-bottom: 24px; }
  .header h1 { font-size: 1.2rem; color: #f5c842; margin: 0; }
  .header p { color: #888; font-size: 0.8rem; margin: 6px 0 0; }
  .card { background: #1a1a1a; border-radius: 12px; padding: 16px 20px; margin-bottom: 16px; }
  .card-title { font-size: 0.75rem; color: #888; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 14px; }

  /* 金句 */
  .quote-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
  .quote-item {
    background: #1f1f00;
    border: 1px solid #3a3a00;
    border-radius: 8px;
    padding: 10px 12px;
    font-size: 0.82rem;
    line-height: 1.6;
    color: #f5e680;
  }
  .quote-num { font-size: 0.65rem; color: #888; margin-bottom: 4px; }

  /* 關鍵字 */
  .tag-wrap { display: flex; flex-wrap: wrap; gap: 8px; }
  .tag {
    background: #2a2a2a;
    border: 1px solid #3a3a3a;
    border-radius: 20px;
    padding: 4px 14px;
    font-size: 0.8rem;
    color: #ccc;
  }

  /* 轉單文案 */
  .copy-item { display: flex; gap: 10px; padding: 7px 0; border-bottom: 1px solid #2a2a2a; font-size: 0.82rem; }
  .copy-item:last-child { border-bottom: none; }
  .copy-label { flex-shrink: 0; color: #f5c842; font-size: 0.72rem; width: 90px; padding-top: 2px; }
  .copy-text { flex: 1; line-height: 1.5; color: #ccc; }

  /* Threads 預覽 */
  .threads-preview {
    background: #111;
    border: 1px solid #2a2a2a;
    border-radius: 12px;
    padding: 16px;
    font-size: 0.85rem;
    line-height: 1.9;
    white-space: pre-wrap;
    color: #ddd;
  }
  .threads-avatar {
    width: 32px; height: 32px;
    background: #f5c842;
    border-radius: 50%;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 0.75rem;
    color: #000;
    font-weight: bold;
    margin-bottom: 10px;
  }
  .threads-name { font-size: 0.78rem; color: #aaa; margin-left: 8px; vertical-align: middle; }
</style>
</head>
<body>

<div class="header">
  <h1>💡 學習心得洞察卡</h1>
  <p>{{來源}} ／ {{作者}}｜{{YYYY-MM-DD}}</p>
</div>

<div class="card">
  <div class="card-title">金句 10 則</div>
  <div class="quote-grid">
    {{金句列表HTML}}
  </div>
</div>

<div class="card">
  <div class="card-title">關鍵字</div>
  <div class="tag-wrap">
    {{關鍵字列表HTML}}
  </div>
</div>

<div class="card">
  <div class="card-title">轉單文案 10 句</div>
  {{轉單文案列表HTML}}
</div>

<div class="card">
  <div class="card-title">Threads 貼文預覽</div>
  <div><span class="threads-avatar">J</span><span class="threads-name">@thisisj587</span></div>
  <div class="threads-preview">{{Threads貼文內容}}</div>
</div>

</body>
</html>
```

### 變數說明

| 變數 | 填入規則 |
|------|---------|
| `{{來源}}` | 步驟三填寫的來源名稱 |
| `{{作者}}` | 步驟三填寫的作者 |
| `{{YYYY-MM-DD}}` | 當日日期 |
| `{{金句列表HTML}}` | 每則金句產出：`<div class="quote-item"><div class="quote-num">01</div>金句內容</div>`，共 10 則 |
| `{{關鍵字列表HTML}}` | 每個關鍵字產出：`<span class="tag">關鍵字</span>` |
| `{{轉單文案列表HTML}}` | 每句產出：`<div class="copy-item"><span class="copy-label">【密碼名稱】</span><span class="copy-text">文案內容</span></div>` |
| `{{Threads貼文內容}}` | 任務四的貼文全文，換行保留 |

存檔完成後告知使用者：

```
📄 HTML 報告已產出：learning-insight-YYYYMMDD.html
路徑：C:\Users\Jeff Chen\iCloudDrive\Claude\my-agent\html-demo\
用瀏覽器開啟後，按 F12 → Ctrl+Shift+P → 輸入 screenshot → 選「Capture full size screenshot」即可存成圖片。
```

