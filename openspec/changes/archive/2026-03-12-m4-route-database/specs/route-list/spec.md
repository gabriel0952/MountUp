## ADDED Requirements

### Requirement: 顯示路線列表
系統 SHALL 在底部導覽「路線」tab 顯示所有預建路線卡片，每張卡片顯示：路線名稱、地區、難度標籤、距離（km）、總爬升（m）、封面照片縮圖。

#### Scenario: 載入路線列表
- **WHEN** 用戶點擊底部導覽「路線」tab
- **THEN** 系統從 assets 載入路線資料並顯示列表，卡片依照路線名稱排序

#### Scenario: 空狀態
- **WHEN** assets 中無任何路線資料
- **THEN** 系統顯示「暫無路線資料」提示文字

### Requirement: 依難度篩選
系統 SHALL 提供難度篩選器（全部 / 輕鬆 / 中等 / 困難），篩選後僅顯示符合難度的路線。

#### Scenario: 選擇難度篩選
- **WHEN** 用戶點擊難度篩選選項「中等」
- **THEN** 列表僅顯示 `difficulty == medium` 的路線

#### Scenario: 重置篩選
- **WHEN** 用戶點擊「全部」
- **THEN** 列表顯示所有路線

### Requirement: 依地區篩選
系統 SHALL 提供地區篩選器（全部 / 北部 / 中部 / 南部 / 東部），可與難度篩選組合使用。

#### Scenario: 組合篩選
- **WHEN** 用戶同時選擇難度「輕鬆」與地區「北部」
- **THEN** 列表僅顯示同時符合兩個條件的路線

### Requirement: 點擊路線卡片導航至詳情
系統 SHALL 在用戶點擊路線卡片後導航至對應路線詳情頁。

#### Scenario: 點擊卡片
- **WHEN** 用戶點擊路線卡片
- **THEN** 系統導航至 `/routes/:id` 詳情頁
