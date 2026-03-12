## ADDED Requirements

### Requirement: 手動建立活動
系統 SHALL 允許使用者不透過 GPS 追蹤，手動輸入活動資料建立紀錄。必填欄位為「活動名稱」與「日期」，其餘欄位（距離、爬升、時間）為選填。

#### Scenario: 成功建立
- **WHEN** 使用者填入名稱與日期後點擊「儲存」
- **THEN** 系統建立 Activity 記錄（trackJson=null、status=completed），返回列表頁並顯示新紀錄

#### Scenario: 名稱為空
- **WHEN** 使用者未填名稱就點擊「儲存」
- **THEN** 系統顯示錯誤提示，不執行儲存

### Requirement: 日期預設為今天且可修改
手動建立活動時，系統 SHALL 預設日期為當天，使用者可透過日期選擇器修改。

#### Scenario: 修改日期
- **WHEN** 使用者點擊日期欄位
- **THEN** 顯示系統日期選擇器，確認後更新欄位值

### Requirement: 從列表頁進入手動建立
系統 SHALL 在活動列表頁提供入口讓使用者進入手動建立活動頁面。

#### Scenario: 進入手動建立頁
- **WHEN** 使用者點擊列表頁的「手動新增」入口
- **THEN** 導航至手動建立活動頁面
