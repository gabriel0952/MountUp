## 1. 依賴套件

- [x] 1.1 在 pubspec.yaml 新增 `image_picker`、`flutter_image_compress`、`path_provider`
- [x] 1.2 執行 `flutter pub get` 確認無衝突
- [x] 1.3 iOS Info.plist 確認已有相機與相簿權限描述（M1 已加，確認即可）

## 2. 修復追蹤儲存

- [x] 2.1 在 `tracking_page.dart` 的 `onSave` callback 中注入 `activityRepositoryProvider`
- [x] 2.2 將 `TrackingSessionState.trackPoints` 序列化為 JSON string
- [x] 2.3 建立 `ActivitiesCompanion` 並呼叫 `ActivityRepository.save()`
- [x] 2.4 儲存成功後呼叫 `ref.invalidate(activityListProvider)` 刷新列表

## 3. PhotoRepository

- [x] 3.1 建立 `lib/features/activity/domain/repositories/photo_repository.dart`（介面：`getByActivityId`、`save`、`delete`）
- [x] 3.2 建立 `lib/features/activity/data/repositories/photo_repository_impl.dart`，實作 DB CRUD 與本機檔案刪除邏輯
- [x] 3.3 建立 `lib/features/activity/presentation/providers/photo_provider.dart`（`photoRepositoryProvider` + `activityPhotosProvider(activityId)`）

## 4. 照片工具

- [x] 4.1 建立 `lib/core/utils/photo_utils.dart`：`compressAndSave(XFile) → String localPath`（壓縮至 1920px、品質 85，存至 documents）
- [x] 4.2 驗證壓縮後檔案 < 2MB

## 5. 活動詳情頁

- [x] 5.1 建立 `lib/features/activity/presentation/pages/activity_detail_page.dart`（接收 `activityId` 參數）
- [x] 5.2 實作統計數據區塊（距離、爬升、時間、日期）
- [x] 5.3 實作 trackJson 反序列化 → Mapbox `PolylineAnnotation` 軌跡顯示，自動 fit bounding box
- [x] 5.4 無 trackJson 時隱藏地圖區塊
- [x] 5.5 實作照片牆（3 欄 GridView，載入 `activityPhotosProvider`）
- [x] 5.6 實作「新增照片」按鈕，呼叫 `image_picker` → `compressAndSave` → `PhotoRepository.save()`
- [x] 5.7 實作長按照片 → 確認 Dialog → `PhotoRepository.delete()`
- [x] 5.8 實作筆記 TextField，onChange debounce 800ms 後呼叫 `ActivityRepository.save()`，離頁強制 flush
- [x] 5.9 實作 AppBar 刪除按鈕 → 確認 Dialog → 刪照片檔案 → 刪 DB → 返回列表

## 6. 手動建立活動頁

- [x] 6.1 建立 `lib/features/activity/presentation/pages/activity_create_page.dart`
- [x] 6.2 實作表單：名稱（必填）、日期（預設今天，可選）、距離/爬升/時間（選填）
- [x] 6.3 表單驗證：名稱不可為空
- [x] 6.4 儲存時呼叫 `ActivityRepository.save()`，完成後返回列表

## 7. 路由與導航

- [x] 7.1 在 `app_router.dart` 新增 `/activities/:id` 路由（`ActivityDetailPage`）
- [x] 7.2 在 `app_router.dart` 新增 `/activities/create` 路由（`ActivityCreatePage`）
- [x] 7.3 `ActivityCard` 加上 `onTap` 導航至 `/activities/:id`
- [x] 7.4 `ActivityListPage` FAB 改為 SpeedDial 或 BottomSheet，提供「開始追蹤」與「手動新增」兩個入口
