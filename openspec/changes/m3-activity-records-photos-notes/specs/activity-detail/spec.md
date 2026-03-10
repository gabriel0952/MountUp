## ADDED Requirements

### Requirement: 追蹤結束後儲存活動至 DB
追蹤結束，使用者確認標題後，系統 SHALL 將活動統計數據（距離、爬升、時間）與 trackJson（TrackPoint 陣列序列化）寫入 Drift `Activities` 表。

#### Scenario: 儲存成功
- **WHEN** 使用者在 TrackingSummarySheet 輸入標題並點擊「儲存活動」
- **THEN** 系統建立一筆 Activity 記錄（status=completed），活動列表頁立即顯示新紀錄

#### Scenario: 標題為空
- **WHEN** 使用者清空標題欄位後點擊「儲存活動」
- **THEN** 系統不執行儲存，顯示錯誤提示

### Requirement: 活動詳情頁顯示統計數據
系統 SHALL 提供活動詳情頁，顯示距離（km）、總爬升（m）、移動時間（HH:mm:ss）、日期。

#### Scenario: 從列表點擊進入詳情
- **WHEN** 使用者點擊活動列表中的任一卡片
- **THEN** 導航至該活動的詳情頁，顯示所有統計數據

### Requirement: 詳情頁顯示 GPS 軌跡地圖
若活動含有 trackJson，系統 SHALL 在詳情頁用 Mapbox 地圖顯示完整軌跡，並自動調整視角至軌跡 bounding box。

#### Scenario: 有軌跡資料
- **WHEN** 詳情頁載入且 trackJson 非空
- **THEN** 地圖顯示藍色軌跡線，相機自動 fit 至軌跡範圍

#### Scenario: 無軌跡資料（手動建立）
- **WHEN** 詳情頁載入且 trackJson 為 null
- **THEN** 隱藏地圖區塊，不顯示地圖

### Requirement: 刪除活動
系統 SHALL 允許使用者從詳情頁刪除活動，刪除前 SHALL 顯示確認 Dialog。刪除時一併移除關聯的照片檔案與 DB 記錄。

#### Scenario: 確認刪除
- **WHEN** 使用者點擊「刪除」並在 Dialog 確認
- **THEN** 系統先刪除本機照片檔案，再刪除 ActivityPhotos 與 Activity DB 記錄，返回列表頁

#### Scenario: 取消刪除
- **WHEN** 使用者點擊「刪除」後在 Dialog 取消
- **THEN** 不執行任何操作，留在詳情頁
