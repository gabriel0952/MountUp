## Context

M2 完成後，`TrackingNotifier` 已能記錄 GPS 軌跡、計算統計數據，並在追蹤結束時觸發 `TrackingSummarySheet`。然而 `onSave` callback 僅做頁面跳轉，未呼叫任何 repository，導致資料全部遺失。

Drift DB schema（`Activities`、`ActivityPhotos`）與 `ActivityRepository` CRUD 介面已在 M1 定義完畢，本 milestone 主要任務是「接通管線」並補齊 UI 層。

## Goals / Non-Goals

**Goals:**
- 追蹤結束後資料確實寫入 Drift DB
- 提供活動詳情頁：統計、Mapbox 軌跡回放、照片牆、筆記
- 照片從 `image_picker` 拍攝/選取 → 壓縮 → 儲存本機 → 寫入 `ActivityPhotos`
- 手動建立活動（無 GPS）
- 刪除活動（含關聯照片檔案清理）

**Non-Goals:**
- 照片 GPS 標記 UI（欄位已預留，顯示留 M4 後）
- 地圖上查看拍攝位置
- 雲端上傳（M7）
- Markdown 渲染（只做純文字筆記）

## Decisions

### 1. 軌跡序列化格式：JSON in Drift `trackJson` 欄位

`TrackPoint` 已有 `toJson()`（freezed 生成），直接 `jsonEncode(trackPoints.map(...).toList())` 存入 `TEXT` 欄位。

**替代方案**：獨立 `track_points` table → 過度設計，M3 不需要逐點查詢。

### 2. 照片壓縮：`flutter_image_compress`

壓縮至最長邊 1920px、品質 85，寫入 APP documents 目錄（`path_provider`）。原始檔不保留。

**替代方案**：不壓縮直接存 → 平均照片 5–8MB，長期使用儲存空間不可接受。

### 3. 詳情頁軌跡回放：Mapbox `PolylineAnnotation`

從 `trackJson` 反序列化後建立 `PolylineAnnotationOptions`，與追蹤頁共用相同邏輯。地圖設為不可互動（gestures disabled）以簡化 UX，僅顯示 bounding box 範圍。

**替代方案**：`MapSnapshotter` 產生靜態圖 → 留給 M6 分享卡片使用，詳情頁用互動地圖體驗更好。

### 4. 筆記自動儲存：debounce 800ms

`TextField` onChange 觸發 800ms debounce timer，時間到後呼叫 `ActivityRepository.save()`（update）。離頁時強制 flush。

### 5. PhotoRepository 獨立介面

不把照片 CRUD 塞進 `ActivityRepository`，維持單一職責。`PhotoRepositoryImpl` 同時管理 DB 記錄與檔案系統操作。

## Risks / Trade-offs

- **[Risk] trackJson 過大** → GPS 1Hz 記錄，6 小時約 21,600 點，序列化後約 3–5MB。可接受，未來可考慮降頻或 zlib 壓縮。
- **[Risk] 照片刪除孤兒檔** → APP crash 在 DB 刪除後、檔案刪除前會有殘留。Mitigation：先刪檔案，再刪 DB 記錄，失敗時 DB 記錄仍在，下次可重試。
- **[Trade-off] 詳情頁用互動地圖** → 比靜態圖耗資源，但與追蹤頁一致，程式碼重用率高。

## Open Questions

- 手動新增活動的日期預設今天，使用者可修改（已決定）。
