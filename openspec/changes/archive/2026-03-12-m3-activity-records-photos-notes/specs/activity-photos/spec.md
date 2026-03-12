## ADDED Requirements

### Requirement: 從相機或相簿附加照片至活動
系統 SHALL 允許使用者在活動詳情頁透過 `image_picker` 拍照或從相簿選取照片，並附加至當前活動。

#### Scenario: 選取照片成功
- **WHEN** 使用者點擊「新增照片」並選取一張圖片
- **THEN** 系統壓縮圖片（最長邊 1920px、品質 85）、儲存至 APP documents 目錄、寫入 `ActivityPhotos` DB，照片牆立即顯示新照片

#### Scenario: 使用者取消選取
- **WHEN** 使用者開啟選圖介面後取消
- **THEN** 不執行任何操作，照片牆不變

### Requirement: 照片牆顯示活動照片
系統 SHALL 在活動詳情頁以網格方式顯示所有附加照片，依 `takenAt`（或 `sortOrder`）排序。

#### Scenario: 有照片
- **WHEN** 活動詳情頁載入且有關聯照片
- **THEN** 以 3 欄網格顯示照片縮圖

#### Scenario: 無照片
- **WHEN** 活動詳情頁載入且無關聯照片
- **THEN** 顯示「尚無照片，點擊新增」提示區塊

### Requirement: 刪除單張照片
系統 SHALL 允許使用者長按照片縮圖後刪除該張照片，刪除前 SHALL 顯示確認 Dialog。

#### Scenario: 確認刪除照片
- **WHEN** 使用者長按照片並確認刪除
- **THEN** 系統刪除本機檔案與 DB 記錄，照片牆移除該縮圖

### Requirement: 照片壓縮不超過 2MB
系統 SHALL 確保壓縮後每張照片檔案大小不超過 2MB。

#### Scenario: 大圖壓縮
- **WHEN** 使用者選取原始大小超過 2MB 的照片
- **THEN** 壓縮後儲存的檔案不超過 2MB
