/// 此檔僅供參考，env.dart 已可直接 commit（無機敏值）
///
/// 本機開發步驟：
///   1. cp dart_defines.example.json dart_defines.json
///   2. 在 dart_defines.json 填入真實金鑰
///   3. flutter run（VSCode 會自動透過 --dart-define-from-file 注入）
///
/// CLI 執行：
///   flutter run --dart-define-from-file=dart_defines.json
class Env {
  Env._();

  static const mapboxToken = String.fromEnvironment('MAPBOX_TOKEN');
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
}
