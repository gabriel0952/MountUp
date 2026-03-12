## Why

健行結束後，用戶沒有直接從 APP 產生精美分享圖的管道，需手動截圖再裁切，體驗粗糙。SNS 分享卡片功能讓用戶一鍵生成帶有軌跡地圖、統計數據的圖卡，完成「記錄 → 分享」的完整迴圈，是 P0 MVP 最後一塊缺口。

## What Changes

- 新增「分享卡片」頁面（`ShareCardPage`），從活動詳情頁進入
- 支援兩種格式：**1:1 正方形**（Instagram 貼文）與 **9:16 直式**（Instagram 限動）
- 使用 `MapSnapshotter` 產生靜態地圖底圖（避開 PlatformView 截圖限制）
- 使用 `dart:ui Canvas` 在底圖上疊加：GPX 軌跡線、起終點標記、統計數字區塊、APP Logo
- 支援「存至相簿」（`gal`）與「直接分享」（`share_plus`）
- 在活動詳情頁 AppBar 新增分享 Icon 按鈕入口

## Capabilities

### New Capabilities

- `share-card`: 分享卡片生成、預覽、格式切換與匯出（存相簿 / 系統分享）

### Modified Capabilities

- `activity-detail`: 新增 AppBar 分享按鈕，導航至 `ShareCardPage`

## Impact

- 新增套件：`share_plus`（分享）；`gal` 已在 M3 引入（存相簿）
- 新增頁面：`lib/features/share/presentation/pages/share_card_page.dart`
- 新增路由：`/activities/:id/share`
- 依賴 M3 活動資料（`trackJson`、統計欄位）與 Mapbox `MapSnapshotter` API
- `activity_detail_page.dart` 小幅修改（加 AppBar 按鈕）
