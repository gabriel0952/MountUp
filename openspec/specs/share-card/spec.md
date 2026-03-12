## ADDED Requirements

### Requirement: 分享卡片格式選擇
用戶 SHALL 能在分享卡片頁面切換 1:1 正方形與 9:16 直式兩種格式。

#### Scenario: 預設顯示 1:1 格式
- **WHEN** 用戶進入 `ShareCardPage`
- **THEN** 預覽區顯示 1:1 正方形格式的合成卡片

#### Scenario: 切換格式
- **WHEN** 用戶點擊格式切換按鈕（正方形 / 限動）
- **THEN** 預覽區即時更新為對應尺寸的合成卡片

### Requirement: 地圖底圖生成
系統 SHALL 使用 `MapSnapshotter` 產生靜態地圖底圖，涵蓋活動軌跡的 bounding box。

#### Scenario: 有 trackJson 時產生軌跡地圖
- **WHEN** 活動含有 `trackJson`
- **THEN** 底圖顯示 Mapbox Outdoors 風格地圖，範圍自動 fit 軌跡 bounding box（四邊 padding 各 40pt）

#### Scenario: 無 trackJson 時降級為台灣全圖
- **WHEN** 活動不含 `trackJson`
- **THEN** 底圖顯示台灣全島範圍的 Mapbox Outdoors 底圖

### Requirement: 軌跡疊加
系統 SHALL 在地圖底圖上以 Canvas 繪製活動軌跡線與起終點標記。

#### Scenario: 繪製軌跡線
- **WHEN** 合成流程執行且活動有軌跡點
- **THEN** Canvas 繪製橘紅色（#FF5722）、寬度 4px 的 Polyline 連接所有軌跡座標

#### Scenario: 繪製起終點標記
- **WHEN** 合成流程執行且活動有軌跡點
- **THEN** 起點繪製綠色圓點，終點繪製紅色圓點，半徑 8px，附白色描邊 2px

### Requirement: 數據文字區塊
系統 SHALL 在卡片底部疊加含距離、爬升、時間、日期與路線名稱的數據區塊。

#### Scenario: 1:1 格式數據區塊
- **WHEN** 合成 1:1 格式
- **THEN** 卡片底部 30% 高度為半透明深色漸層，上方顯示路線名稱（大字）、距離 / 爬升 / 時間（三欄數字）、日期，右下角顯示「MountUp」文字 Logo

#### Scenario: 9:16 格式數據區塊
- **WHEN** 合成 9:16 格式
- **THEN** 地圖佔上方 70% 面積，下方 30% 為深色純底色數據區（同 1:1 內容，字體放大 1.2×）

### Requirement: 卡片匯出
用戶 SHALL 能將合成卡片存至相簿或透過系統分享傳送。

#### Scenario: 存至相簿
- **WHEN** 用戶點擊「存至相簿」按鈕
- **THEN** 系統以 PNG 格式（1080px 長邊）呼叫 `gal.putImageBytes()`，成功後顯示「已存至相簿」SnackBar

#### Scenario: 系統分享
- **WHEN** 用戶點擊「分享」按鈕
- **THEN** 系統呼叫 `share_plus.shareXFiles()`，傳入暫存 PNG 檔案，開啟系統分享選單

#### Scenario: 匯出過程顯示載入狀態
- **WHEN** 合成或匯出進行中
- **THEN** 按鈕顯示 `CircularProgressIndicator`，禁止重複點擊
