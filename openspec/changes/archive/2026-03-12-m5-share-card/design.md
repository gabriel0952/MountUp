## Context

Flutter 的 `screenshot` 套件無法擷取 PlatformView（Mapbox 地圖），是已知限制。SPEC.md 明確指出需使用 **MapSnapshotter** 產生靜態底圖 bitmap，再用 `dart:ui Canvas` 合成數據圖層。目前 M3 活動詳情頁已有地圖（`PolylineAnnotation`），但其底圖是即時 MapWidget，不能直接截圖。M5 的挑戰在於用純 Canvas 重現地圖上的軌跡視覺效果，並支援兩種輸出尺寸。

## Goals / Non-Goals

**Goals:**
- 從活動詳情頁一鍵進入分享卡片預覽
- 支援 1:1（1080×1080）與 9:16（1080×1920）兩種格式
- MapSnapshotter 產生地圖底圖 → Canvas 疊加軌跡與數據 → PNG bytes
- 存至相簿（`gal`）或系統分享（`share_plus`）
- 無 trackJson 的活動仍可生成純數據版本（不含地圖）

**Non-Goals:**
- 自訂卡片顏色/字型（P1 以後）
- 影片格式
- 批次匯出多筆活動
- 分享至特定社群平台 API（用系統分享即可）

## Decisions

### D1：地圖底圖使用 MapSnapshotter

`MapSnapshotter` 是 Mapbox 原生 API，可在背景 isolate 以 style + bounds 產生 `ui.Image`，不依賴 Widget tree，也不受 PlatformView 限制。替代方案：靜態地圖 API（需額外網路請求）、純 Canvas 手繪（效果差）。選 MapSnapshotter 最符合離線優先原則且品質最高。

### D2：Canvas 合成在主 isolate 執行

MapSnapshotter 的 `start()` 回傳 `ui.Image`，合成（`drawImage` + `drawPath` + `drawParagraph`）的計算量小，直接在 UI isolate 執行即可，不需 `compute()`。

### D3：格式切換以 enum 控制尺寸

```dart
enum ShareCardFormat { square, story }
```

兩種格式共用同一個合成 pipeline，只改 `canvasWidth / canvasHeight` 與數據區塊佈局比例，避免 code 重複。

### D4：軌跡座標從 trackJson 反序列化，bounding box 傳入 Snapshotter

沿用 M3 `_drawTrack` 的反序列化邏輯，計算 sw/ne bounds 後傳入 `MapSnapshotOptions.bounds`，確保地圖視角與活動範圍吻合。

### D5：預覽以 RawImage(image: ui.Image) 呈現

預覽 Widget 直接顯示合成後的 `ui.Image`，使用者確認後再呼叫 `image.toByteData(format: ImageByteFormat.png)` 取得 bytes，避免重複合成。

## Risks / Trade-offs

- **MapSnapshotter 在 iOS Simulator 可能有黑圖問題** → 以實機測試為準；若遇到加 `await Future.delayed(Duration(milliseconds: 100))` 確保 style 載入
- **MapSnapshotter 需要有效 Mapbox Token** → 已在 M4 透過 `dart-define-from-file` 注入，無額外工作
- **無 trackJson 時無法顯示軌跡** → 降級為純底圖（fit 台灣全島）+ 數據卡片，仍可匯出
- **Canvas 文字渲染需手動管理 ParagraphBuilder** → 相對繁瑣，但是唯一可跨平台在 canvas 上畫文字的方式

## Open Questions

- 卡片底部 APP Logo 使用文字（"MountUp"）還是圖片 asset？→ 先用文字，後期換設計稿
