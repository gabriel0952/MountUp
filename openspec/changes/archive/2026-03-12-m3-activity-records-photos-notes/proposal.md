## Why

M1/M2 完成了 GPS 追蹤與地圖功能，但追蹤結束後資料無法真正寫入 DB、也沒有詳情頁可以查閱與管理紀錄。M3 補齊「活動日記」核心循環：追蹤 → 儲存 → 查閱 → 編輯照片筆記，讓 APP 成為可日常使用的健行記錄工具。

## What Changes

- **修復**：追蹤結束的 `onSave` 正確呼叫 `ActivityRepository.save()`，將軌跡序列化後寫入 Drift DB
- **新增**：活動詳情頁（統計數據、Mapbox 軌跡回放、照片牆、Markdown 筆記）
- **新增**：照片功能（`image_picker` 拍照/選圖 → 壓縮 → 本機路徑 → `ActivityPhotos` DB）
- **新增**：`PhotoRepository`：`ActivityPhotos` 表的 CRUD
- **新增**：筆記編輯（TextField + debounce 自動儲存）
- **新增**：刪除活動（含確認 Dialog，同步刪除關聯照片檔案）
- **新增**：手動建立活動（無 GPS，手動輸入距離/爬升/時間）
- **更新**：`ActivityCard` 點擊導航至詳情頁
- **更新**：`ActivityListPage` FAB 分拆為「開始追蹤」與「手動新增」

## Capabilities

### New Capabilities

- `activity-detail`: 活動詳情頁，顯示統計、地圖軌跡、照片牆與筆記，支援編輯與刪除
- `activity-photos`: 照片附加功能，從相機或相簿選取後壓縮儲存，與活動關聯
- `activity-manual-create`: 不透過 GPS，手動填入活動資料建立紀錄

### Modified Capabilities

## Impact

- **修改**：`lib/features/tracking/presentation/pages/tracking_page.dart`（onSave 實作）
- **修改**：`lib/features/activity/presentation/pages/activity_list_page.dart`（FAB、card tap）
- **修改**：`lib/features/activity/presentation/widgets/activity_card.dart`（tap 導航）
- **修改**：`lib/routing/app_router.dart`（新增詳情頁、手動新增頁路由）
- **新增**：`lib/features/activity/presentation/pages/activity_detail_page.dart`
- **新增**：`lib/features/activity/presentation/pages/activity_create_page.dart`
- **新增**：`lib/features/activity/data/repositories/photo_repository_impl.dart`
- **新增**：`lib/features/activity/domain/repositories/photo_repository.dart`
- **新增**：`lib/features/activity/presentation/providers/photo_provider.dart`
- **依賴**：`image_picker`、`flutter_image_compress`（需加入 pubspec.yaml）
