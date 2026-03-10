# MountUp

台灣山友的戶外健行紀錄 APP。

## 產品定位

個人健行日記——不需登入即可在本機記錄每次出行；登入後資料自動同步至雲端。

## 適用情境

- **出發前**：查看路線資料庫規劃行程；用裝備清單確認不漏帶
- **健行中**：GPS 即時追蹤，地圖疊加 GPX 預定路線，隨時拍照
- **下山後**：查看距離 / 爬升 / 時間統計；撰寫筆記；生成 SNS 分享卡片

## 核心功能（MVP）

| 功能 | 說明 |
|------|------|
| 活動記錄 | 日期、路線、距離、爬升、時間，可手動或 GPS 自動填入 |
| GPS 即時追蹤 | 地圖即時顯示軌跡，疊加 GPX 預定路線 |
| 照片 / 筆記 | 照片帶 GPS 標記，可在地圖上查看拍攝位置 |
| 路線資料庫 | 官方預建台灣熱門路線（含 GPX 下載） |
| SNS 分享卡片 | 1:1 貼文卡 & 9:16 限動卡，含軌跡縮圖與數據 |
| 裝備清單 | 自訂清單，出發前勾選確認 |

## 技術棧

| 層級 | 技術 |
|------|------|
| Framework | Flutter 3.x / Dart 3.x |
| 狀態管理 | Riverpod |
| 導航 | go_router |
| 地圖 | flutter_map + OpenStreetMap |
| GPS | geolocator |
| 後端（P1） | Supabase（Auth + PostgreSQL + Storage） |
| 本地儲存 | Hive |
| Data Class | freezed |
| 錯誤處理 | fpdart (Either) |

## 專案結構

```
MountUp/
├── app/               # Flutter 專案主目錄
│   └── lib/
│       ├── core/      # 共用元件、常數、工具
│       ├── features/  # 功能模組（activity, tracking, routes, gear, share, auth）
│       ├── routing/   # go_router 設定
│       └── main.dart
├── docs/
│   ├── PRD.md         # 產品需求文件
│   ├── SPEC.md        # 技術規格（DB Schema、架構、資料流）
│   └── TODO.md        # MVP 開發計畫（7 個 Milestones）
└── CLAUDE.md          # 開發規範
```

## 開始開發

```bash
cd app
flutter pub get
flutter run
```

## 文件

- [產品需求 (PRD)](docs/PRD.md)
- [技術規格 (SPEC)](docs/SPEC.md)
- [開發計畫 (TODO)](docs/TODO.md)

## 授權

Private — All rights reserved.
