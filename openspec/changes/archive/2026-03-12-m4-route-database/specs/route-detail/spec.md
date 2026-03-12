## ADDED Requirements

### Requirement: 顯示路線資訊
系統 SHALL 在路線詳情頁顯示：封面照片、路線名稱、地區、難度標籤、距離（km）、總爬升（m）、路線簡介文字。

#### Scenario: 進入詳情頁
- **WHEN** 用戶從路線列表點擊路線卡片
- **THEN** 詳情頁顯示該路線的完整資訊區塊

### Requirement: GPX 地圖預覽
系統 SHALL 在詳情頁嵌入 Mapbox 地圖，解析對應 GPX 檔案並以 PolylineAnnotation 顯示路線軌跡，地圖自動 fit 至軌跡 bounding box。

#### Scenario: 正常載入 GPX
- **WHEN** 詳情頁載入且對應 GPX 檔案存在
- **THEN** 地圖顯示完整路線軌跡，視角自動對齊軌跡範圍

#### Scenario: GPX 不存在
- **WHEN** 對應 GPX 檔案不存在或解析失敗
- **THEN** 隱藏地圖區塊，不顯示錯誤 crash

### Requirement: 開始追蹤並預載路線
系統 SHALL 在路線詳情頁提供「開始追蹤」按鈕，點擊後導航至追蹤頁並預載該路線 GPX。

#### Scenario: 點擊開始追蹤
- **WHEN** 用戶點擊詳情頁「開始追蹤」按鈕
- **THEN** 系統導航至追蹤頁，且該路線 GPX 已疊加顯示於追蹤地圖上

### Requirement: 返回路線列表
系統 SHALL 提供返回按鈕讓用戶回到路線列表頁。

#### Scenario: 點擊返回
- **WHEN** 用戶點擊 AppBar 返回按鈕
- **THEN** 系統返回路線列表頁，篩選狀態保持不變
