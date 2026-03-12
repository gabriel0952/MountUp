class Env {
  Env._();

  // 所有金鑰統一從 dart_defines.json 注入（--dart-define-from-file）
  // 本機開發：複製 dart_defines.example.json → dart_defines.json 並填入真實值

  static const mapboxToken = String.fromEnvironment('MAPBOX_TOKEN');
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
}
