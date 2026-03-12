## 1. 依賴套件

- [x] 1.1 在 `pubspec.yaml` 新增 `share_plus`（系統分享）
- [x] 1.2 確認 `gal` 已存在（M3 已引入）；執行 `flutter pub get` 確認無衝突

## 2. 路由設定

- [x] 2.1 在 `app_router.dart` 新增 `/activities/:id/share` 路由，對應 `ShareCardPage(activityId: id)`
- [x] 2.2 在 `activity_detail_page.dart` AppBar 新增 `Icons.ios_share` 按鈕，`onPressed` 導航至 `/activities/:id/share`

## 3. ShareCardFormat enum

- [x] 3.1 建立 `lib/features/share/domain/share_card_format.dart`，定義 `enum ShareCardFormat { square, story }`，附 `width`、`height`（long edge = 1080px）getter

## 4. 合成核心：ShareCardComposer

- [x] 4.1 建立 `lib/features/share/domain/share_card_composer.dart`（pure Dart，無 Flutter Widget 依賴）
- [x] 4.2 實作 `Future<ui.Image> compose(Activity activity, ShareCardFormat format)` 方法
- [x] 4.3 反序列化 `activity.trackJson` → `List<TrackPoint>`，計算軌跡 sw/ne bounding box
- [x] 4.4 呼叫 `MapSnapshotter.start(MapSnapshotOptions(...))` 取得地圖底圖 `ui.Image`（無 trackJson 時用台灣全島 bounds：sw(119.9, 21.8) ne(122.1, 25.4)）
- [x] 4.5 建立 `ui.PictureRecorder` + `Canvas`，繪製底圖（`drawImage`）
- [x] 4.6 實作 `_drawPolyline(Canvas, List<TrackPoint>, bounds, canvasSize)`：將地理座標線性映射至 canvas 座標，繪製橘紅色軌跡線
- [x] 4.7 實作 `_drawEndpoints(Canvas, ...)`：起點綠色圓點、終點紅色圓點（附白描邊）
- [x] 4.8 實作 `_drawDataOverlay(Canvas, Activity, ShareCardFormat)`：底部漸層遮罩 + `ParagraphBuilder` 繪製路線名、距離/爬升/時間三欄、日期、「MountUp」Logo 文字
- [x] 4.9 `picture.endRecording()` → `toImage()` 回傳 `ui.Image`

## 5. ShareCardPage UI

- [x] 5.1 建立 `lib/features/share/presentation/pages/share_card_page.dart`（`ConsumerStatefulWidget`，接收 `activityId`）
- [x] 5.2 讀取 `activityRepositoryProvider` 取得活動資料；載入中顯示 `CircularProgressIndicator`
- [x] 5.3 初始化時呼叫 `ShareCardComposer.compose()` 產生預覽圖；以 `RawImage(image: _preview)` 顯示
- [x] 5.4 實作格式切換 SegmentedButton（正方形 / 限動），切換後重新呼叫 `compose()` 更新預覽
- [x] 5.5 實作「存至相簿」按鈕：`image.toByteData(ImageByteFormat.png)` → `gal.putImageBytes()`，成功 SnackBar；按鈕合成中顯示 spinner
- [x] 5.6 實作「分享」按鈕：PNG bytes 寫入 `Directory.systemTemp` 暫存檔 → `share_plus.shareXFiles()`；按鈕合成中顯示 spinner
- [x] 5.7 AppBar 標題「分享卡片」，左側返回按鈕

## 6. iOS / Android 平台設定

- [x] 6.1 確認 iOS `Info.plist` 已有 `NSPhotoLibraryAddUsageDescription`（M3 已加，確認即可）
- [x] 6.2 確認 Android `AndroidManifest.xml` `gal` 所需權限已存在（M3 已加）
