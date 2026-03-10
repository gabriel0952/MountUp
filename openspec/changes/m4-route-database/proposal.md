## Why

M1–M3 已完成 GPS 追蹤與活動日記核心功能，但地圖上僅能追蹤自己的軌跡，沒有預建路線可參考。M4 補齊「出發前規劃」環節：路線資料存放於 Supabase（PostgreSQL + Storage），讓管理者可隨時新增更新路線，App 透過 API 取得資料並本地快取，確保離線環境也能瀏覽已快取路線。

## What Changes

- **新增**：Supabase `routes` 資料表資料（SPEC.md §2 已定義 schema）及 GPX / 封面照片上傳至 Supabase Storage
- **新增**：路線列表頁，支援依難度 / 地區篩選
- **新增**：路線詳情頁，顯示封面照片、距離/爬升、GPX 地圖預覽、簡介
- **新增**：從路線詳情可直接「開始追蹤」（預載 GPX 至追蹤頁）
- **新增**：`RouteRepository`：從 Supabase 拉取路線資料，快取至本地 Drift SQLite
- **新增**：本地 Drift `routes` 表做離線快取（SPEC.md §2 schema 對應）
- **更新**：手動建立活動時，可從路線資料庫選取路線名稱（自動填入）
- **更新**：底部導覽「路線」tab 從空殼接通路線列表頁
- **更新**：`supabase_flutter` 套件提前至 M4 引入（原規劃 P1，但讀取 routes 不需登入）

## Capabilities

### New Capabilities

- `route-list`: 路線列表頁，顯示所有路線，支援依難度 / 地區篩選，離線時顯示本地快取
- `route-detail`: 路線詳情頁，顯示路線資訊與 GPX 地圖預覽，可直接開始追蹤
- `route-repository`: 從 Supabase 拉取路線資料並快取至 Drift SQLite 的 data layer

### Modified Capabilities

- `activity-manual-create`: 建立活動時可從路線資料庫選取路線名稱

## Impact

- **新增**：`lib/features/route/` feature 資料夾（data / domain / presentation 三層）
- **新增**：Drift `routes` 表定義（AppDatabase migration）
- **修改**：`lib/features/activity/presentation/pages/activity_create_page.dart`（路線選取入口）
- **修改**：`lib/routing/app_router.dart`（新增路線列表與詳情路由）
- **修改**：底部導覽列 routes tab 接通 `RouteListPage`
- **依賴**：`supabase_flutter`（提前引入，僅用匿名讀取 routes）
