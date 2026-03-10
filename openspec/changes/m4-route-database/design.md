## Context

M1–M3 已建立 GPS 追蹤（Mapbox）、活動記錄（Drift）與照片筆記。SPEC.md §2 已定義 `routes` 表 schema（Supabase PostgreSQL），§3 已定義 RLS（`read_routes: FOR SELECT USING (true)`，無需登入即可讀取）。Supabase Storage 存放 `gpx_url` 與 `cover_url`。

原方案（assets 靜態檔）捨棄，改為 Supabase 遠端資料，同時保留本地 Drift 快取支援離線。

## Goals / Non-Goals

**Goals:**
- 路線資料由 Supabase 管理，管理者可隨時新增 / 修改路線而不需更新 App
- 首次有網路時下載路線清單與 GPX，快取至 Drift SQLite
- 離線時使用已快取資料，無快取時顯示提示
- 路線列表可依難度、地區篩選
- 路線詳情可預覽 GPX 地圖與路線資訊
- 從路線詳情一鍵跳至追蹤頁並預載 GPX

**Non-Goals:**
- 登入驗證（routes RLS 允許匿名讀取）
- UGC 用戶投稿路線（P1）
- 離線地圖 Pack 下載（P2）
- 路線收藏 / 評分

## Decisions

### 決策 1：資料來源 — Supabase PostgreSQL + Storage

**選擇**：路線 metadata 存 Supabase `routes` 表，GPX 與封面照片存 Supabase Storage（bucket: `route-assets`，public bucket）。

**理由**：
- SPEC.md §2 已有此設計，直接對應不增加新 schema
- RLS `FOR SELECT USING (true)` 允許匿名讀取，P0 無需登入
- 管理者可透過 Supabase Dashboard 更新路線，App 無需重新上架

**替代方案考慮**：
- 本機 assets：無法動態更新、bundle 增大，已排除

### 決策 2：本地快取 — Drift `routes` 表 + GPX 二進位快取

**選擇**：
- Routes metadata：快取至 Drift `routes` 表（mirror Supabase schema，額外加 `cached_at` 欄位）
- GPX 檔案：下載後存至 app documents 目錄（`routes/<id>.gpx`），路徑存入 Drift `routes.gpx_local_path`
- 封面照片：使用 `cached_network_image` 套件自動管理 HTTP 快取

**快取失效策略**：
- App 每次啟動有網路時，後台靜默更新（`updated_at > cached_at` 才覆寫）
- 離線時直接讀 Drift 快取，若無任何快取則顯示「請連線以載入路線資料」

**理由**：符合「離線優先」原則；GPX 存本地避免每次地圖渲染都需網路

### 決策 3：supabase_flutter 提前引入

**選擇**：M4 引入 `supabase_flutter`，在 `main.dart` 初始化 Supabase client（anon key 透過 `--dart-define` 注入，同 Mapbox token 做法）。

**理由**：routes 是公開唯讀資料，不需 Auth；P1 帳號功能直接沿用此 client

### 決策 4：GPX 地圖預覽 — compute() isolate 解析

**選擇**：讀取本地快取 GPX → 在 `compute()` isolate 用 `gpx` 套件解析 → 回傳 `LatLng` list → 主 isolate 渲染 `PolylineAnnotation`。

**理由**：GPX 檔案可能 > 1MB，主 isolate 解析會造成 UI 卡頓

### 決策 5：封面照片 — cached_network_image

**選擇**：封面圖片使用 `cached_network_image` widget 直接讀 Supabase Storage public URL，由套件自動管理磁碟快取。

**理由**：不需自己管理圖片快取邏輯，且路線圖僅讀取不寫入

## Risks / Trade-offs

- **[Risk] 首次使用無網路**：完全無快取 + 無網路時無法顯示任何路線 → 顯示說明訊息引導連線
- **[Risk] Supabase Storage 費用**：GPX 與圖片下載量計費 → 初期路線數少（≤20），流量不超標
- **[Risk] GPX 快取過期**：路線更新但本地仍用舊 GPX → 透過 `updated_at` 比對決定是否重新下載
- **[Trade-off]** 需網路才能看到最新路線 vs. assets 完全離線：接受，因可動態更新的價值更大

## Migration Plan

1. Supabase Dashboard 建立 `route-assets` bucket（public）
2. 上傳 GPX 檔案與封面照片至 Storage
3. 在 `routes` 表插入路線 metadata（`gpx_url` / `cover_url` 填 Storage public URL）
4. App 端 Drift migration 新增 `routes` 表
5. 初始化 Supabase client（`main.dart`）

## Open Questions

- Supabase project URL 與 anon key 由使用者提供後填入 `env.dart`
