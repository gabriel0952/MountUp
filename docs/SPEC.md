# MountUp 技術規格文件（Technical Specification）

## 1. 系統架構總覽

### 離線優先架構

```
┌─────────────────────────────────────────────────┐
│                  Flutter App                    │
│  ┌──────────┐  ┌──────────┐  ┌───────────────┐ │
│  │Presentation│  │  Domain  │  │     Data      │ │
│  │ (Widgets) │  │(Use Cases)│  │(Repos+Drift) │ │
│  └──────────┘  └──────────┘  └───────────────┘ │
│                                      │           │
│                               ┌──────▼──────┐   │
│                               │ Drift/SQLite │   │
│                               └──────┬──────┘   │
└──────────────────────────────────────│───────────┘
                                       │ P1: 登入後同步
                              ┌────────▼────────┐
                              │    Supabase      │
                              │ PostgreSQL + S3  │
                              └─────────────────┘
```

### 套件選型

| 功能 | 套件 | 說明 |
|------|------|------|
| 地圖 | `mapbox_maps_flutter` >=2.18 | Mapbox Outdoors style，等高線 + 地形陰影，離線 Pack 下載；需 Flutter >=3.27、compileSdk 35 |
| GPS 定位 | `geolocator` + `flutter_foreground_task` | geolocator 提供位置串流；flutter_foreground_task 以前景 Service 通知列保持 iOS/Android 背景存活 |
| GPX 解析 | `gpx` | 解析 .gpx 路線檔 |
| GPX 匯入 | `file_picker` | 從 Files / AirDrop 匯入外部 .gpx，指定 allowedExtensions: ['gpx'] |
| 分享卡片合成 | Mapbox `MapSnapshotter` + `dart:ui` Canvas | ⚠️ 不用 screenshot 套件（PlatformView 無法截圖）；改用 MapSnapshotter 產生底圖 bitmap 後 canvas 疊加數據 |
| 照片選取 | `image_picker` | 相機 / 相簿 |
| 照片壓縮 | `flutter_image_compress` | 上傳前壓縮 |
| 分享匯出 | `share_plus` + `image_gallery_saver` | 存相簿 / 直接分享 |
| 本地 DB | `drift` + `drift_flutter` | SQLite 基礎，type-safe，支援關聯查詢；積極維護中（取代 Hive，Isar 原作者已於 2025/01 棄坑） |
| 雲端後端 | `supabase_flutter` | P1 Auth + 同步 |
| 狀態管理 | `flutter_riverpod` | |
| 導航 | `go_router` | |
| Data class | `freezed` + `json_serializable` | |
| 錯誤處理 | `fpdart` | Either / Option |

### 已知風險備忘

| 風險 | 說明 | 對策 |
|------|------|------|
| 分享卡地圖空白 | `screenshot` 無法捕捉 PlatformView（Mapbox） | 使用 `MapSnapshotter` 產生靜態 bitmap，再用 Canvas 合成 |
| iOS 背景 GPS 中斷 | `geolocator` 單獨使用在 iOS 後台不穩定 | 搭配 `flutter_foreground_task` 掛常駐通知 |
| GPS 軌跡漂移 | 樹林下精度差，點位跳動造成距離虛高 | 過濾 accuracy > 20m 的點，可加簡單移動平均平滑 |
| Mapbox Token 安全 | Token 不可 hardcode 進程式碼 | Android: local.properties + gradle；iOS: Info.plist (.gitignore)；或 --dart-define 注入 |
| Mapbox 費用 | 超過 50k map loads/月 開始計費 | 上架後在 Mapbox Console 監控，初期個人用量不會超標 |

---

## 2. DB Schema（Drift/SQLite 本機 / Supabase PostgreSQL）

### activities（活動記錄）

```sql
CREATE TABLE activities (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID REFERENCES auth.users,   -- P1: 登入後填入
  route_id    UUID REFERENCES routes(id),   -- 可為 null（自訂路線）
  title       TEXT NOT NULL,
  date        DATE NOT NULL,
  distance_km NUMERIC(6,2),
  elevation_m INTEGER,
  duration_s  INTEGER,                      -- 移動秒數
  status      TEXT DEFAULT 'completed',     -- 'in_progress' | 'completed'
  notes       TEXT,
  track_json  JSONB,                        -- GPS 軌跡點陣列 [{lat,lng,ele,ts}]
  created_at  TIMESTAMPTZ DEFAULT now(),
  updated_at  TIMESTAMPTZ DEFAULT now()
);
```

### routes（路線資料庫）

```sql
CREATE TABLE routes (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name         TEXT NOT NULL,
  region       TEXT,                        -- 北部、中部、南部、東部
  difficulty   TEXT,                        -- 'easy' | 'moderate' | 'hard' | 'expert'
  distance_km  NUMERIC(6,2),
  elevation_m  INTEGER,
  description  TEXT,
  gpx_url      TEXT,                        -- Storage 路徑
  cover_url    TEXT,
  is_official  BOOLEAN DEFAULT TRUE,
  author_id    UUID REFERENCES auth.users,  -- P1 UGC
  created_at   TIMESTAMPTZ DEFAULT now()
);
```

### activity_photos（活動照片）

```sql
CREATE TABLE activity_photos (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  activity_id UUID NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
  url         TEXT NOT NULL,               -- 本機路徑 或 Storage URL
  lat         NUMERIC(9,6),
  lng         NUMERIC(9,6),
  taken_at    TIMESTAMPTZ,
  sort_order  INTEGER DEFAULT 0
);
```

### gear_lists（裝備清單）

```sql
CREATE TABLE gear_lists (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID REFERENCES auth.users,
  name       TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);
```

### gear_items（裝備項目）

```sql
CREATE TABLE gear_items (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  gear_list_id UUID NOT NULL REFERENCES gear_lists(id) ON DELETE CASCADE,
  name         TEXT NOT NULL,
  category     TEXT,                       -- '衣物' | '糧食' | '急救' | '導航' | '其他'
  is_checked   BOOLEAN DEFAULT FALSE,
  sort_order   INTEGER DEFAULT 0
);
```

---

## 3. RLS（Row Level Security）政策（P1）

```sql
-- activities: 只能讀寫自己的資料
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own_activities" ON activities
  USING (user_id = auth.uid());

-- routes: 所有人可讀；只有 official 或本人可寫
ALTER TABLE routes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read_routes" ON routes FOR SELECT USING (true);
CREATE POLICY "write_own_routes" ON routes FOR INSERT
  WITH CHECK (author_id = auth.uid());

-- gear_lists / gear_items: 同 activities
ALTER TABLE gear_lists ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own_gear_lists" ON gear_lists
  USING (user_id = auth.uid());
```

---

## 4. Flutter 應用架構

```
lib/
├── core/
│   ├── constants/        # 顏色、尺寸、路由名稱
│   ├── errors/           # Failure 類別
│   ├── extensions/       # DateTime、num 擴充
│   └── widgets/          # 共用 Widget（AppBar、LoadingOverlay）
│
├── features/
│   ├── activity/
│   │   ├── data/
│   │   │   ├── datasources/  # DriftActivityDataSource
│   │   │   ├── models/       # ActivityModel (freezed + Drift table)
│   │   │   └── repositories/ # ActivityRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/     # Activity
│   │   │   ├── repositories/ # ActivityRepository (abstract)
│   │   │   └── usecases/     # CreateActivity, GetActivities, ...
│   │   └── presentation/
│   │       ├── providers/    # activityListProvider, activeTrackingProvider
│   │       ├── pages/        # ActivityListPage, ActivityDetailPage
│   │       └── widgets/      # ActivityCard, StatsBadge
│   │
│   ├── tracking/             # GPS 追蹤 & 地圖
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       └── pages/        # TrackingPage (地圖 + 即時數據)
│   │
│   ├── routes/               # 路線資料庫
│   ├── gear/                 # 裝備清單
│   ├── share/                # SNS 分享卡片
│   └── auth/                 # P1: 帳號登入 / 同步
│
├── routing/
│   └── app_router.dart       # go_router 設定
│
└── main.dart
```

---

## 5. 資料流

### GPS 追蹤流程

```
flutter_foreground_task 啟動前景 Service（顯示通知列）
  → TrackingNotifier.startTracking()
  → geolocator.getPositionStream()
  → 每個點先過濾 accuracy > 20m
  → 推入 trackPoints: List<TrackPoint>（移動平均平滑）
  → 同步更新 currentDistance / currentElevation
  → 使用者點「結束」
  → flutter_foreground_task 停止 Service
  → 產生 Activity entity
  → ActivityRepository.save(activity)
  → Drift DB insert
```

### 分享卡片生成流程

```
⚠️ 不使用 screenshot 套件（PlatformView 限制）

ShareCardPage(activityId)
  → 讀取 Activity + 軌跡 TrackPoints
  → MapSnapshotter.start(style, bounds, width, height)
      → 產生含底圖的靜態 ui.Image（原生 bitmap）
  → dart:ui Canvas 在 bitmap 上疊加：
      PolylineLayer（軌跡線）、起終點標記
  → 再用 Canvas 合成數據文字區塊（距離/爬升/時間）
  → image_gallery_saver.saveImage(pngBytes)
  → share_plus.shareXFiles([tmpFile])
```

### P1 雲端同步流程

```
登入成功
  → 讀取本機 Drift DB 所有未同步 activities
  → Supabase.from('activities').upsert(records)
  → 上傳照片至 Supabase Storage
  → 標記本機記錄為 synced
  → 訂閱 Realtime 更新（跨裝置）
```

---

## 6. MVP 功能與技術對照

| 功能 | 技術實作 | 資料儲存 |
|------|----------|----------|
| 活動記錄 CRUD | Riverpod + Drift | Drift SQLite（activities 表） |
| GPS 追蹤 | geolocator + flutter_foreground_task | 追蹤中暫存記憶體，結束後存 Drift |
| 地圖顯示 | mapbox_maps_flutter（Outdoors style） | Mapbox Offline Pack 快取 |
| GPX 路線疊加 | gpx 解析 → PolylineAnnotation | assets/ 路線庫或使用者匯入 |
| 外部 GPX 匯入 | file_picker → gpx 解析 → Drift 儲存 | Drift SQLite（gpx_tracks 表） |
| 照片附加 | image_picker + flutter_image_compress | 本機路徑存 Drift |
| 路線資料庫 | 本機 JSON assets（官方預建） | assets/routes/*.json |
| 裝備清單 | Riverpod + Drift | Drift SQLite（gear_lists / gear_items 表） |
| SNS 分享卡片 | MapSnapshotter + dart:ui Canvas | 暫存 PNG 至 temp dir → 相簿 / 分享 |
| 帳號登入（P1） | supabase_flutter Auth | Secure Storage |
| 雲端同步（P1） | Supabase REST + Realtime | PostgreSQL + Storage |
