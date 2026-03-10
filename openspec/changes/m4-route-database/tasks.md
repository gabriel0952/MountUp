## 1. 環境與依賴

- [x] 1.1 在 `pubspec.yaml` 新增 `supabase_flutter`、`cached_network_image`
- [x] 1.2 執行 `flutter pub get` 確認無衝突
- [x] 1.3 在 `lib/core/constants/env.dart` 新增 `supabaseUrl` 與 `supabaseAnonKey` 常數（String.fromEnvironment）
- [x] 1.4 在 `main.dart` 初始化 Supabase client：`await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey)`

## 2. Supabase 後台設定

- [x] 2.1 在 Supabase Dashboard 建立 `route-assets` Storage bucket（public）
- [x] 2.2 上傳 10 條台灣熱門路線 GPX 檔案至 `route-assets/gpx/<id>.gpx`
- [x] 2.3 上傳對應封面照片至 `route-assets/covers/<id>.jpg`（壓縮至 < 300KB）
- [x] 2.4 確認 `routes` 表已存在（SPEC.md §2），若無則執行建表 SQL
- [x] 2.5 確認 RLS 政策已套用：`read_routes FOR SELECT USING (true)`
- [x] 2.6 在 `routes` 表插入 10 條路線資料（填入 `gpx_url`、`cover_url` 為 Storage public URL）

## 3. Drift 本地快取 Schema

- [x] 3.1 在 AppDatabase 新增 `RoutesTable`（欄位對應 SPEC.md routes schema，額外加 `gpx_local_path TEXT`、`cached_at DATETIME`）
- [x] 3.2 新增 Drift migration（schemaVersion 遞增），加入 `RoutesTable`
- [x] 3.3 執行 `dart run build_runner build` 重新生成 Drift 程式碼

## 4. Domain Layer

- [x] 4.1 建立 `lib/features/route/domain/entities/route_entity.dart`（freezed：id、name、region、difficulty、distanceKm、elevationM、description、gpxUrl、coverUrl、isOfficial、gpxLocalPath）
- [x] 4.2 建立 `lib/features/route/domain/repositories/route_repository.dart`（介面：`fetchAll`、`getById`、`getGpx`，回傳 fpdart `Either`）

## 5. Data Layer

- [x] 5.1 建立 `lib/features/route/data/models/route_model.dart`（fromJson 對應 Supabase response，toCompanion 寫入 Drift）
- [x] 5.2 建立 `lib/features/route/data/datasources/route_remote_datasource.dart`（`supabase.from('routes').select()`、Storage URL 組合）
- [x] 5.3 建立 `lib/features/route/data/datasources/route_local_datasource.dart`（Drift CRUD：getAll、getById、upsert、updateGpxLocalPath）
- [x] 5.4 建立 `lib/features/route/data/repositories/route_repository_impl.dart`（實作 fetchAll 快取策略、getGpx 懶下載邏輯、背景更新 `updated_at` 比對）
- [x] 5.5 建立 `lib/features/route/presentation/providers/route_provider.dart`（`routeRepositoryProvider`、`routeListProvider`、`routeByIdProvider(id)`）

## 6. 路線列表頁

- [x] 6.1 建立 `lib/features/route/presentation/pages/route_list_page.dart`（ConsumerWidget，載入 `routeListProvider`）
- [x] 6.2 建立 `lib/features/route/presentation/widgets/route_card.dart`（`CachedNetworkImage` 封面縮圖、名稱、地區、難度 chip、距離/爬升）
- [x] 6.3 實作難度篩選 FilterChip 列（全部/輕鬆/中等/困難）
- [x] 6.4 實作地區篩選 FilterChip 列（全部/北部/中部/南部/東部），可與難度組合
- [x] 6.5 實作 in-memory filtering 邏輯（本地快取資料篩選）
- [x] 6.6 實作載入中 skeleton UI 與無快取離線提示（「請連線以載入路線資料」）

## 7. 路線詳情頁

- [x] 7.1 建立 `lib/features/route/presentation/pages/route_detail_page.dart`（接收 `routeId` 參數）
- [x] 7.2 實作資訊區塊：`CachedNetworkImage` 封面（Hero animation）、名稱、地區、難度 chip、距離、爬升、簡介
- [x] 7.3 呼叫 `RouteRepository.getGpx(id)` 取得 GPX，在 `compute()` isolate 解析為 `LatLng` list
- [x] 7.4 實作 GPX 地圖預覽（MapboxMap + PolylineAnnotation，自動 fit bounding box）
- [x] 7.5 GPX 載入中顯示 CircularProgressIndicator；無 GPX 或失敗時隱藏地圖區塊
- [x] 7.6 實作「開始追蹤」按鈕，傳入 GPX 內容導航至追蹤頁

## 8. 路由與導航

- [x] 8.1 在 `app_router.dart` 新增 `/routes` 路由（`RouteListPage`）
- [x] 8.2 在 `app_router.dart` 新增 `/routes/:id` 路由（`RouteDetailPage`）
- [x] 8.3 底部導覽列「路線」tab 接通 `/routes`（取代空殼 placeholder）

## 9. 手動建立活動整合

- [x] 9.1 在 `activity_create_page.dart` 路線名稱欄位旁新增「選取路線」IconButton
- [x] 9.2 點擊後顯示路線選取 BottomSheet（從 `routeListProvider` 載入，含搜尋框）
- [x] 9.3 選取路線後自動填入路線名稱 TextField，關閉 BottomSheet

## 10. 追蹤頁整合與背景更新

- [x] 10.1 確認 `TrackingPage` 可接收外部 GPX string 參數；若未支援則在 `TrackingNotifier` 新增 `loadExternalGpx(String gpxContent)` 方法
- [x] 10.2 在 `main.dart` 或 App 啟動 provider 中觸發背景靜默更新（`routeRepository.fetchAll()` 於 splash 後非同步執行）
