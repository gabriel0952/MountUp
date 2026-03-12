## ADDED Requirements

### Requirement: 從 Supabase 拉取路線列表
系統 SHALL 提供 `RouteRepository.fetchAll()` 方法，從 Supabase `routes` 表讀取所有 `is_official = true` 的路線，回傳 `List<RouteEntity>`；同時將結果快取至本地 Drift `routes` 表。

#### Scenario: 有網路時正常拉取
- **WHEN** 呼叫 `RouteRepository.fetchAll()` 且裝置有網路
- **THEN** 從 Supabase 取回路線列表，更新 Drift 快取，回傳 `Right(List<RouteEntity>)`

#### Scenario: 無網路時使用快取
- **WHEN** 呼叫 `RouteRepository.fetchAll()` 且裝置無網路
- **THEN** 從 Drift 快取讀取並回傳 `Right(List<RouteEntity>)`（可能為空 list）

#### Scenario: 無網路且無快取
- **WHEN** 呼叫 `RouteRepository.fetchAll()`、裝置無網路、Drift 快取為空
- **THEN** 回傳 `Left(NetworkFailure)`

### Requirement: 讀取單一路線
系統 SHALL 提供 `RouteRepository.getById(String id)` 方法，優先從 Drift 快取讀取，快取無資料時向 Supabase 查詢。

#### Scenario: 快取命中
- **WHEN** 傳入有效的路線 id 且 Drift 快取存在該路線
- **THEN** 回傳 `Right(RouteEntity)`，不發出網路請求

#### Scenario: 快取未命中且有網路
- **WHEN** 傳入有效的 id 且 Drift 無此筆資料，但有網路
- **THEN** 向 Supabase 查詢並回傳 `Right(RouteEntity)`，同時寫入快取

#### Scenario: 找不到路線
- **WHEN** 傳入不存在的 id
- **THEN** 回傳 `Left(NotFoundFailure)`

### Requirement: 取得路線 GPX
系統 SHALL 提供 `RouteRepository.getGpx(String routeId)` 方法，若本地已快取 GPX 檔案則直接讀取，否則從 Supabase Storage 下載並儲存至 app documents 目錄。

#### Scenario: 本地 GPX 已快取
- **WHEN** 呼叫 `RouteRepository.getGpx(id)` 且本地 documents 目錄存在對應 GPX 檔案
- **THEN** 讀取本地檔案，回傳 `Right(String gpxContent)`

#### Scenario: 本地無快取，從 Storage 下載
- **WHEN** 本地無 GPX 快取且有網路
- **THEN** 從 `gpx_url` 下載 GPX，儲存至 `documents/routes/<id>.gpx`，回傳 `Right(String gpxContent)`

#### Scenario: 無網路且無本地快取
- **WHEN** 本地無 GPX 快取且無網路
- **THEN** 回傳 `Left(NetworkFailure)`

### Requirement: 背景靜默更新
系統 SHALL 在 App 啟動且有網路時，背景比對 Supabase `routes.updated_at` 與本地 `cached_at`，對有更新的路線重新下載 metadata 與 GPX。

#### Scenario: 發現路線有更新
- **WHEN** App 啟動時偵測到某路線 `updated_at > cached_at`
- **THEN** 重新下載 metadata 更新 Drift 快取，並刪除舊 GPX 本地檔案（新 GPX 待下次進入詳情頁時懶載入）
