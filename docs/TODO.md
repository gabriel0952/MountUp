# MountUp MVP 開發計畫

> 對應 PRD P0 所有功能，分為 7 個 Milestone 依序開發。
> 每個 Milestone 結束時應有可運行的交付物。

---

## Milestone 1：專案初始化 & 基礎建設

**目標**：建立可跑的空殼 APP，所有基礎套件設定完成。

### 任務
- [ ] `flutter create` 建立 app 資料夾，設定 Flutter 3.x
- [ ] 加入依賴套件（riverpod、go_router、drift、freezed、fpdart、mapbox_maps_flutter、geolocator、flutter_foreground_task 等）
- [ ] 建立 `lib/` 資料夾結構（參考 SPEC.md §4）
- [ ] 設定 go_router，建立底部導覽列（首頁、路線、裝備、設定）
- [ ] 設定 Drift：建立 AppDatabase，定義所有 Table，執行 migration
- [ ] 建立 core/constants（顏色、主題、尺寸）
- [ ] 設定 iOS / Android 權限（定位、相機、相簿）
- [ ] CI：`flutter analyze` + `flutter test` 通過

**交付物**：可安裝到裝置、顯示底部導覽的空殼 APP

---

## Milestone 2：GPS 即時追蹤 & 地圖

**目標**：使用者可開始追蹤，地圖即時顯示軌跡與目前位置。

### 任務
- [ ] 整合 `geolocator` 取得位置串流，加入 accuracy 過濾（> 20m 捨棄）與移動平均平滑
- [ ] 整合 `flutter_foreground_task`，啟動/停止追蹤時同步控制前景 Service（iOS/Android 背景存活）
- [ ] 建立 `TrackingNotifier`（StateNotifier）管理追蹤狀態
- [ ] 整合 `mapbox_maps_flutter`，設定 Mapbox Outdoors style
- [ ] 即時繪製 PolylineAnnotation（已行走軌跡）
- [ ] 顯示即時數據覆蓋層（距離、時間、速度）
- [ ] GPX 路線疊加：從路線資料庫自動載入
- [ ] GPX 外部匯入：`file_picker` 選 .gpx 檔 → 解析 → 疊加地圖
- [ ] 結束追蹤：計算距離、爬升、時間
- [ ] 處理定位權限拒絕的 UI 狀態

**交付物**：可開啟 GPS 追蹤、看到地圖與即時數據、結束後看到統計

---

## Milestone 3：活動記錄 & 照片筆記

**目標**：活動資料可完整儲存、查閱、編輯，並附加照片與筆記。

### 任務
- [ ] 設計 `Activity` entity + Hive model（freezed）
- [ ] 實作 `ActivityRepository`（本機 Hive CRUD）
- [ ] 追蹤結束後自動建立活動紀錄
- [ ] 活動列表頁：依日期排序，顯示距離/爬升/時間
- [ ] 活動詳情頁：統計數據、地圖軌跡回放、照片牆、筆記
- [ ] 手動新增活動（無 GPS 資料）
- [ ] 整合 `image_picker`：從相機 / 相簿選照片附加至活動
- [ ] 照片壓縮 + 本機路徑儲存
- [ ] 文字筆記編輯（TextField + 自動儲存）
- [ ] 刪除活動（含確認 Dialog）

**交付物**：完整的活動日記功能（紀錄、查閱、照片、筆記）

---

## Milestone 4：路線資料庫

**目標**：提供官方預建台灣路線列表，可預覽並載入 GPX 至地圖。

### 任務
- [ ] 建立 `assets/routes/` 存放路線 JSON 與 GPX 檔案
- [ ] 收錄 10–20 條台灣熱門路線（資料格式參考 SPEC §2）
- [ ] 路線列表頁：支援依難度 / 地區篩選
- [ ] 路線詳情頁：封面照片、距離/爬升、GPX 地圖預覽、簡介
- [ ] 從路線詳情可直接「開始追蹤」（預載 GPX）
- [ ] 建立活動時可從路線資料庫選取路線名稱

**交付物**：可瀏覽路線、查看詳情、帶 GPX 直接開始健行

---

## Milestone 5：裝備清單

**目標**：使用者可管理多個裝備清單，出發前快速核對。

### 任務
- [ ] 設計 `GearList` / `GearItem` entity + Hive model
- [ ] 裝備清單列表頁（可新增 / 刪除清單）
- [ ] 清單編輯頁：新增 / 刪除 / 排序裝備項目，設定類別
- [ ] 「出發核對」模式：勾選介面，顯示進度（X/N 已備妥）
- [ ] 複製清單功能（範本複用）
- [ ] 出發後重置勾選狀態

**交付物**：完整裝備清單管理，出發前確認流程可用

---

## Milestone 6：SNS 分享卡片

**目標**：可從活動詳情生成 1:1 與 9:16 分享卡，存相簿或直接分享。

### 任務
- [ ] ⚠️ **不使用 screenshot 套件**（PlatformView 截圖為空白）
- [ ] 用 Mapbox `MapSnapshotter` 產生靜態地圖 bitmap（指定 bounds = 軌跡 bounding box）
- [ ] 用 `dart:ui` Canvas 在 bitmap 上疊加軌跡線、起終點標記
- [ ] Canvas 合成數據文字區塊（距離/爬升/時間/路線名），產出最終 PNG bytes
- [ ] 建立分享卡預覽頁（可切換 1:1 / 9:16 格式）
- [ ] 存至相簿（`image_gallery_saver`）
- [ ] 直接分享（`share_plus`）

**交付物**：可從任意活動生成精美分享卡片並匯出

---

## Milestone 7：帳號 & 雲端同步（P1）

**目標**：可選登入，登入後本機資料同步至 Supabase 雲端。

### 任務
- [ ] 建立 Supabase 專案，設定 Schema（參考 SPEC §2）
- [ ] 設定 RLS 政策（參考 SPEC §3）
- [ ] 整合 `supabase_flutter`，實作 Email / Google 登入
- [ ] 登入後：上傳本機未同步 activities 至 Supabase
- [ ] 照片上傳至 Supabase Storage
- [ ] 裝備清單同步
- [ ] 跨裝置 Realtime 同步（Supabase Realtime）
- [ ] 登出：清除本機 session，資料保留本機

**交付物**：可登入並雲端備份，換裝置後登入恢復資料
