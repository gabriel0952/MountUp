## MODIFIED Requirements

### Requirement: 手動建立活動 — 路線名稱可從資料庫選取
建立活動時，路線名稱欄位 SHALL 提供「從路線資料庫選取」入口，用戶可瀏覽路線列表並選取，選取後自動填入路線名稱欄位；用戶仍可自由輸入自訂名稱。

#### Scenario: 點擊從資料庫選取
- **WHEN** 用戶在手動建立活動頁點擊路線名稱欄位旁的「選取路線」按鈕
- **THEN** 系統顯示路線選取 BottomSheet，列出所有預建路線

#### Scenario: 選取路線後自動填入
- **WHEN** 用戶在 BottomSheet 選取某條路線
- **THEN** BottomSheet 關閉，路線名稱欄位自動填入該路線名稱

#### Scenario: 自訂名稱優先
- **WHEN** 用戶在路線名稱欄位直接輸入文字
- **THEN** 欄位顯示用戶輸入的自訂名稱，不受資料庫選取影響
