/// 複製此檔為 env.dart 並填入對應的 token
/// cp lib/core/constants/env.example.dart lib/core/constants/env.dart
class Env {
  Env._();

  // 取得方式：https://account.mapbox.com/
  static const mapboxToken = String.fromEnvironment(
    'MAPBOX_TOKEN',
    defaultValue: 'YOUR_MAPBOX_PUBLIC_TOKEN',
  );
}
