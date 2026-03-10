class Env {
  Env._();

  // pk.* 是公開 token，可安全放在 client 端。
  // 正式發布時透過 --dart-define=MAPBOX_TOKEN=pk.xxx 覆蓋。
  static const mapboxToken = String.fromEnvironment(
    'MAPBOX_TOKEN',
    defaultValue:
        'pk.eyJ1IjoiZ2EwOTUyYnJpZWwiLCJhIjoiY21jaHBoeTd4MHY2ejJxc2NyeGg3eWlhZCJ9.8RtrRPtzqEIadD2aMYAROQ',
  );
}
