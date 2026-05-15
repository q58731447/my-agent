---
name: health-record
description: 每日健康紀錄存入 Heptabase SOP — 收到含有體重、入睡時間、三餐（早/午/晚）、超慢跑等欄位的每日紀錄後，自動計算當日達成率，並將整理好的紀錄存入 Heptabase「我的健康人生」白板。當使用者貼上含有「今日體重」「入睡時間」「超慢跑」「早餐」「晚餐」等字樣的每日紀錄，或說「存健康紀錄」「瘦身紀錄」「/health-record」時，務必使用此 skill，不需詢問確認，直接執行。
---

# 每日健康紀錄存入 Heptabase

## 步驟一：解析使用者提供的紀錄

從使用者提供的內容中，擷取以下欄位（若欄位空白或未提供，標記為「未填寫」）：

- **日期**：格式 YYYYMMDD
- **今日體重**（kg）
- **昨日體重**（kg）
- **入睡時間**（HH:MM，24 小時制）
- **超慢跑時間**（分鐘，無紀錄則為 0）
- **早餐**：內容、結果（未超標 / 稍微超標 / 明顯超標）、評語
- **午餐**：內容、結果、評語
- **晚餐**：內容、結果、評語
- **點心**：是否有點心、內容、結果

---

## 步驟二：計算達成率

共 **9 個目標**，逐一判斷：

| # | 名稱 | 目標 | 達成條件 |
|---|------|------|---------|
| 1 | 子時歸息 | 於 24:00（子時）前入睡 | 入睡時間 ≤ 23:59 |
| 2 | 亥末調息 | 於 23:50 前入睡 | 入睡時間 ≤ 23:50 |
| 3 | 月落養神 | 於 23:30 前入睡 | 入睡時間 ≤ 23:30 |
| 4 | 輕功步訣 | 完成超慢跑（有開始即達成） | 超慢跑時間 > 0 分鐘 |
| 5 | 晨膳守量 | 早餐份量未超標 | 早餐結果包含「未超標」 |
| 6 | 午膳守量 | 午餐份量未超標 | 午餐結果包含「未超標」 |
| 7 | 暮膳守量 | 晚餐份量未超標 | 晚餐結果包含「未超標」 |
| 8 | 戒口清心 | 未食含糖油炸點心或點心份量未超標 | 點心結果包含「未超標」，**或**當天無點心 |
| 9 | 收功存錄 | 完成今日體重、睡眠、運動、飲食全紀錄 | 使用者提交當日完整紀錄（預設達成） |

**達成率 = 達成數 ÷ 9 × 100%**（四捨五入，取整數）

---

## 步驟三：組合卡片標題與內容

### 卡片標題格式

```
[YYYYMMDD][健康紀錄][達成率%]
```

範例：`[20260505][健康紀錄][83%]`

---

### 卡片內容格式（純文字）

```
日期：YYYYMMDD
今日體重：XX.X kg　昨日體重：XX.X kg　體重變化：±X.X kg

入睡時間：HH:MM
超慢跑：XX 分鐘

---
【早餐】
內容：...
結果：...
評語：...

【午餐】
內容：...
結果：...
評語：...

【晚餐】
內容：...
結果：...
評語：...

【點心】
有無：有 / 無
內容：...
結果：...

---
【今日達成率】
① 子時歸息（24:00前入睡）：✅ 達成 / ❌ 未達成
② 亥末調息（23:50前入睡）：✅ 達成 / ❌ 未達成
③ 月落養神（23:30前入睡）：✅ 達成 / ❌ 未達成
④ 輕功步訣（超慢跑≥20分鐘）：✅ 達成 / ❌ 未達成
⑤ 晨膳守量（早餐未超標）：✅ 達成 / ❌ 未達成
⑥ 午膳守量（午餐未超標）：✅ 達成 / ❌ 未達成
⑦ 暮膳守量（晚餐未超標）：✅ 達成 / ❌ 未達成
⑧ 戒口清心（點心未超標）：✅ 達成 / ❌ 未達成
⑨ 收功存錄（完成全紀錄）：✅ 達成 / ❌ 未達成

達成：X / 9　達成率：XX%
```

**格式補充說明：**
- 體重變化 = 今日體重 − 昨日體重，負數顯示為「−X.X kg（減輕）」，正數顯示為「+X.X kg（增加）」
- 評語若空白，省略評語那行（不顯示「評語：」）
- 當天無點心，【點心】區塊寫「無（視為達成）」，其他欄位省略
- 未填寫的欄位，填入「未填寫」，對應目標判定為未達成

---

## 步驟四：存入 Heptabase

> ⚠️ **必須使用 `save_to_note_card`，絕對不可使用 `append_to_journal`。**

呼叫 `save_to_note_card`，參數如下：
- **content**：第一行為 `# [YYYYMMDD][健康紀錄][XX%]`（作為卡片標題），後續為步驟三的卡片內容

> ⚠️ `save_to_note_card` 會存入 Heptabase 主空間，**無法直接指定白板**。存入後需手動在 Heptabase 將卡片拖入「我的健康人生」白板。

存入完成後，告知使用者：

```
✅ 健康紀錄已存入 Heptabase！
卡片標題：[YYYYMMDD][健康紀錄][XX%]
今日達成：X / 6 項目標

⚠️ 提醒：請到 Heptabase 主空間，將此卡片手動移入「我的健康人生」白板。
```

---

## 步驟五：產出 HTML 視覺報告

根據步驟一、二的資料，產出以下 HTML 內容，並用 Write 工具存檔至：

```
C:\Users\Jeff Chen\iCloudDrive\Claude\my-agent\html-demo\health-record-YYYYMMDD.html
```

（YYYYMMDD 替換為當日日期）

### HTML 模板

將以下模板中的所有 `{{變數}}` 替換為實際資料後存檔：

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
  .header h1 { font-size: 1.4rem; color: #f5c842; margin: 0; }
  .header p  { color: #888; font-size: 0.85rem; margin: 4px 0 0; }
  .card { background: #1a1a1a; border-radius: 12px; padding: 16px 20px; margin-bottom: 16px; }
  .card-title { font-size: 0.75rem; color: #888; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; }
  .metrics { display: flex; gap: 12px; }
  .metric { flex: 1; background: #242424; border-radius: 10px; padding: 12px; text-align: center; }
  .metric .val { font-size: 1.6rem; font-weight: bold; color: #f5c842; }
  .metric .lbl { font-size: 0.72rem; color: #888; margin-top: 4px; }
  .score-row { display: flex; align-items: center; gap: 20px; }
  .circle-wrap { position: relative; width: 90px; height: 90px; flex-shrink: 0; }
  .circle-wrap svg { transform: rotate(-90deg); }
  .circle-wrap .pct { position: absolute; inset: 0; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; font-weight: bold; color: #4cde80; }
  .score-detail { flex: 1; }
  .score-detail .item { display: flex; justify-content: space-between; font-size: 0.82rem; padding: 4px 0; border-bottom: 1px solid #2a2a2a; }
  .score-detail .item:last-child { border-bottom: none; }
  .ok  { color: #4cde80; }
  .fail{ color: #ff5f5f; }
  .meal-row { display: flex; gap: 10px; }
  .meal { flex: 1; background: #242424; border-radius: 10px; padding: 10px 12px; }
  .meal .m-label { font-size: 0.7rem; color: #888; margin-bottom: 6px; }
  .meal .m-content { font-size: 0.82rem; line-height: 1.5; }
  .bar-wrap { margin-top: 16px; }
  .bar-label { display: flex; justify-content: space-between; font-size: 0.78rem; margin-bottom: 4px; }
  .bar-track { background: #2a2a2a; border-radius: 99px; height: 8px; overflow: hidden; }
  .bar-fill { height: 100%; border-radius: 99px; background: linear-gradient(90deg, #f5c842, #4cde80); }
  .quote { border-left: 3px solid #f5c842; padding-left: 14px; font-size: 0.85rem; line-height: 1.8; color: #ccc; }
</style>
</head>
<body>

<div class="header">
  <h1>⚔️ 瘦身修煉日誌</h1>
  <p>{{YYYY-MM-DD}}</p>
</div>

<div class="card">
  <div class="card-title">今日數據</div>
  <div class="metrics">
    <div class="metric"><div class="val">{{今日體重}}</div><div class="lbl">體重 kg</div></div>
    <div class="metric"><div class="val">{{體重變化}}</div><div class="lbl">昨日差值</div></div>
    <div class="metric"><div class="val">{{入睡時間}}</div><div class="lbl">入睡時間</div></div>
    <div class="metric"><div class="val">{{超慢跑時間}}m</div><div class="lbl">超慢跑</div></div>
  </div>
</div>

<div class="card">
  <div class="card-title">今日達成率</div>
  <div class="score-row">
    <div class="circle-wrap">
      <svg width="90" height="90" viewBox="0 0 90 90">
        <circle cx="45" cy="45" r="38" fill="none" stroke="#2a2a2a" stroke-width="8"/>
        <circle cx="45" cy="45" r="38" fill="none" stroke="#4cde80" stroke-width="8"
          stroke-dasharray="238.76" stroke-dashoffset="{{圓圈offset}}"
          stroke-linecap="round"/>
      </svg>
      <div class="pct">{{達成數}}/9</div>
    </div>
    <div class="score-detail">
      <div class="item"><span>子時歸息</span><span class="{{子時歸息class}}">{{子時歸息符號}}</span></div>
      <div class="item"><span>亥末調息</span><span class="{{亥末調息class}}">{{亥末調息符號}}</span></div>
      <div class="item"><span>月落養神</span><span class="{{月落養神class}}">{{月落養神符號}}</span></div>
      <div class="item"><span>輕功步訣</span><span class="{{輕功步訣class}}">{{輕功步訣符號}}</span></div>
      <div class="item"><span>晨膳守量</span><span class="{{晨膳守量class}}">{{晨膳守量符號}}</span></div>
      <div class="item"><span>午膳守量</span><span class="{{午膳守量class}}">{{午膳守量符號}}</span></div>
      <div class="item"><span>暮膳守量</span><span class="{{暮膳守量class}}">{{暮膳守量符號}}</span></div>
      <div class="item"><span>戒口清心</span><span class="{{戒口清心class}}">{{戒口清心符號}}</span></div>
      <div class="item"><span>收功存錄</span><span class="ok">✅</span></div>
    </div>
  </div>
</div>

<div class="card">
  <div class="card-title">三餐紀錄</div>
  <div class="meal-row">
    <div class="meal"><div class="m-label">早餐</div><div class="m-content">{{早餐內容}}</div></div>
    <div class="meal"><div class="m-label">午餐</div><div class="m-content">{{午餐內容}}</div></div>
    <div class="meal"><div class="m-label">晚餐</div><div class="m-content">{{晚餐內容}}</div></div>
  </div>
  <div class="bar-wrap">
    <div class="bar-label"><span>點心</span><span>{{點心內容}}</span></div>
  </div>
</div>

<div class="card">
  <div class="card-title">今日武俠心得</div>
  <div class="quote">{{武俠心得}}</div>
</div>

</body>
</html>
```

### 變數說明

| 變數 | 填入規則 |
|------|---------|
| `{{YYYY-MM-DD}}` | 日期格式，如 `2026-05-15` |
| `{{今日體重}}` | 數字，如 `83.2` |
| `{{體重變化}}` | 含符號，如 `-0.3` 或 `+0.2` |
| `{{入睡時間}}` | 如 `23:30` |
| `{{超慢跑時間}}` | 分鐘數字，如 `30`；無則填 `0` |
| `{{圓圈offset}}` | 公式：`238.76 × (1 − 達成數/9)`，四捨五入至小數第一位 |
| `{{達成數}}` | 達成目標數，如 `7` |
| 各目標 `class` | 達成填 `ok`，未達成填 `fail` |
| 各目標 `符號` | 達成填 `✅`，未達成填 `❌` |
| `{{早/午/晚餐內容}}` | 換行用 `<br>` 分隔 |
| `{{點心內容}}` | 無點心填 `無（視為達成）` |
| `{{武俠心得}}` | 根據當日資料自動生成 2–3 句武俠風格心得，換行用 `<br>` |

### 武俠心得生成規則

- 以修煉、功法、魔障等武俠意象描述當日狀況
- 提及體重變化、達成亮點、以及 ❌ 未達成項目
- 結尾給一句明日行動方針
- 語氣簡練，約 2–3 句

存檔完成後告知使用者：

```
📄 HTML 報告已產出：health-record-YYYYMMDD.html
路徑：C:\Users\Jeff Chen\iCloudDrive\Claude\my-agent\html-demo\
用瀏覽器開啟後，按 F12 → Ctrl+Shift+P → 輸入 screenshot → 選「Capture full size screenshot」即可存成圖片。
```

---

## 步驟六：草擬 Threads 貼文並詢問是否發佈

### 詢問發佈帳號

草擬貼文前，先詢問使用者：

```
請問這篇健康日誌要發佈到哪個 Threads 帳號？
① @a58731447（個人帳號，預設）
② 其他帳號（請說明）
```

根據使用者選擇，對應呼叫對應 MCP（預設帳號使用 meta-personal）。

---

### Threads 貼文格式

根據步驟一～二的資料，依下方模板草擬貼文（字數控制在 **500 字以內**，語氣自然、去 AI 化）：

```
【瘦身日誌 YYYY.MM.DD】

⚖️ 體重：XX.X kg（↓/↑/維持）
😴 入睡：HH:MM
🏃 超慢跑：XX 分鐘
🎯 達成：X / 9（XX%）

子時歸息：於 24:00 前入睡（✅/❌）
亥末調息：於 23:50 前入睡（✅/❌）
月落養神：於 23:30 前入睡（✅/❌）
輕功步訣：完成超慢跑（✅/❌）
晨膳守量：早餐份量未超標（✅/❌）
午膳守量：午餐份量未超標（✅/❌）
暮膳守量：晚餐份量未超標（✅/❌）
戒口清心：未食含糖油炸點心或點心份量未超標（✅） / 因為有吃 XX 所以（❌）
收功存錄：完成今日全紀錄（✅/❌）

---

（若使用者有提供心得文字，整理為自然段落插入此處；無心得則省略此區塊與分隔線）

#健康管理 #超慢跑 #每日紀錄 #瘦身日誌
```

**撰寫規則：**
- 體重變化為 0，寫「維持」；負數寫「↓X.X kg」；正數寫「↑X.X kg」
- 達成率 ≥ 78%（7/9 以上）可加一句正向收尾，< 45%（4/9 以下）則寫一句輕描淡寫的反思（不批評）
- 超慢跑為 0 分鐘，輕功步訣標記 ❌；有開始（>0 分鐘）即算 ✅
- 無點心當天，戒口清心標記 ✅（視為達成），欄位仍保留
- 戒口清心標記 ❌ 時，需帶入具體點心名稱（格式：「因為有吃 XX 所以（❌）」）
- 語氣需像真人在寫日記，避免「今天表現很好」「持續努力」等制式用語
- 若使用者提供心得文字，在修煉清單後加入 `---` 分隔線，將心得整理為自然段落（去 AI 化、口語化），插入分隔線後
- 全文（含心得）不超過 500 字；心得較長時優先保留核心觀點，刪去重複或說明性文字

### 詢問確認

草擬完成後，輸出貼文內容，並詢問：

```
以上是今日健康日誌的 Threads 貼文草稿，請問可以發佈嗎？
（回覆「可以」或「確認」即發佈；回覆「修改」請告知調整方向）
```

### 發佈貼文

使用者確認後，依選擇的帳號呼叫對應 MCP：

| 帳號 | MCP | 工具前綴 |
|------|-----|---------|
| @a58731447（個人，預設） | `meta-personal`（自架） | `mcp__meta-personal__` |
| @thisisj587 | `meta`（雲端插件） | `mcp__meta__` |

> ⚠️ @a58731447 的 Token 目前已過期，需重新授權後才能使用。

發佈完成後告知：

```
✅ Threads 貼文已發佈！
```
