---
name: knowledge-card
description: 知識卡片建立 SOP — 收到書籍段落、逐字稿、文章內容後，先詢問來源、作者、主旨，再濃縮為 Threads 貼文並存入 Heptabase。當使用者提供書籍內容、逐字稿、心得文字，或說「書籍模式」「心得模式」「知識卡片」「幫我處理這段」時，務必使用此 skill。
---

# 知識卡片建立 SOP

## 步驟一：詢問卡片資訊

收到原文內容後，**先詢問**以下三項，等使用者回答後再繼續：

```
來源：?
作者：?
主旨：?
```

---

## 步驟二：濃縮 Threads 貼文

根據原文產出一篇適合 Threads 的貼文：

- 字數：180～200 字
- 開頭第一句需能吸引人繼續閱讀
- 每段不超過 3 句
- 語氣依內容性質決定（商業偏理性、生活偏親切）
- 段落之間留空行，不加 hashtag

---

## 步驟三：存入 Heptabase

呼叫 `save_to_note_card`，內容如下：

**卡片標題格式**：`[RAW][來源][作者][主旨]`

**卡片內容**：
1. 使用者提供的原文（完整保留）
2. 步驟二產出的 Threads 貼文

存入後告知使用者：「已存入 Heptabase，卡片標題：[RAW][來源][作者][主旨]」

---

## 步驟四：產出 HTML 視覺報告

根據步驟一～三的資料，用 Write 工具存檔至：

```
C:\Users\Jeff Chen\iCloudDrive\Claude\my-agent\html-demo\knowledge-card-YYYYMMDD.html
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
    max-width: 640px;
    margin: auto;
  }
  .header { text-align: center; margin-bottom: 24px; }
  .header .label { font-size: 0.72rem; color: #888; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 8px; }
  .header h1 { font-size: 1.3rem; color: #f5c842; margin: 0 0 6px; line-height: 1.4; }
  .header .meta { font-size: 0.8rem; color: #888; }
  .header .meta span { color: #aaa; }

  .card { background: #1a1a1a; border-radius: 12px; padding: 18px 20px; margin-bottom: 16px; }
  .card-title { font-size: 0.72rem; color: #888; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; }

  /* 原文區塊 */
  .raw-text {
    font-size: 0.85rem;
    line-height: 1.9;
    color: #ccc;
    border-left: 3px solid #333;
    padding-left: 14px;
    white-space: pre-wrap;
  }

  /* 主旨標籤 */
  .subject-tag {
    display: inline-block;
    background: #2a2200;
    border: 1px solid #f5c842;
    color: #f5c842;
    border-radius: 20px;
    padding: 4px 16px;
    font-size: 0.82rem;
    margin-bottom: 14px;
  }

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
  .threads-header { display: flex; align-items: center; gap: 8px; margin-bottom: 12px; }
  .threads-avatar {
    width: 30px; height: 30px;
    background: #f5c842;
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 0.72rem; font-weight: bold; color: #000;
    flex-shrink: 0;
  }
  .threads-name { font-size: 0.78rem; color: #aaa; }
</style>
</head>
<body>

<div class="header">
  <div class="label">📚 知識卡片</div>
  <h1>{{主旨}}</h1>
  <div class="meta">來源：<span>{{來源}}</span>　作者：<span>{{作者}}</span></div>
</div>

<div class="card">
  <div class="card-title">原文摘錄</div>
  <div class="subject-tag">{{主旨}}</div>
  <div class="raw-text">{{原文內容}}</div>
</div>

<div class="card">
  <div class="card-title">Threads 貼文預覽</div>
  <div class="threads-header">
    <div class="threads-avatar">J</div>
    <div class="threads-name">@thisisj587</div>
  </div>
  <div class="threads-preview">{{Threads貼文內容}}</div>
</div>

</body>
</html>
```

### 變數說明

| 變數 | 填入規則 |
|------|---------|
| `{{主旨}}` | 步驟一填寫的主旨 |
| `{{來源}}` | 步驟一填寫的來源 |
| `{{作者}}` | 步驟一填寫的作者 |
| `{{原文內容}}` | 使用者提供的原始內容（完整保留，超過 300 字截取前 300 字並加「……」） |
| `{{Threads貼文內容}}` | 步驟二產出的貼文全文 |

存檔完成後告知使用者：

```
📄 HTML 報告已產出：knowledge-card-YYYYMMDD.html
路徑：C:\Users\Jeff Chen\iCloudDrive\Claude\my-agent\html-demo\
用瀏覽器開啟後，按 F12 → Ctrl+Shift+P → 輸入 screenshot → 選「Capture full size screenshot」即可存成圖片。
```
