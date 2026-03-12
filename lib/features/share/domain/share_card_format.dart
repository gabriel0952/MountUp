enum ShareCardFormat {
  square,
  story;

  int get canvasWidth => 1080;

  int get canvasHeight => switch (this) {
        ShareCardFormat.square => 1080,
        ShareCardFormat.story => 1920,
      };

  /// 地圖快照的高度（story 格式只用上方 70%）
  int get mapHeight => switch (this) {
        ShareCardFormat.square => canvasHeight,
        ShareCardFormat.story => (canvasHeight * 0.70).round(), // 1344
      };

  /// 底部數據區高度
  int get dataHeight => canvasHeight - mapHeight;

  /// 9:16 格式的字體放大倍率
  double get fontScale => switch (this) {
        ShareCardFormat.square => 1.0,
        ShareCardFormat.story => 1.2,
      };
}
