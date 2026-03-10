import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// 壓縮並儲存照片至 APP documents 目錄。
/// 回傳儲存後的本機路徑。
Future<String> compressAndSave(XFile source) async {
  final docsDir = await getApplicationDocumentsDirectory();
  final photosDir = Directory(p.join(docsDir.path, 'photos'));
  if (!await photosDir.exists()) {
    await photosDir.create(recursive: true);
  }

  final fileName =
      '${DateTime.now().millisecondsSinceEpoch}${p.extension(source.path)}';
  final destPath = p.join(photosDir.path, fileName);

  final result = await FlutterImageCompress.compressAndGetFile(
    source.path,
    destPath,
    minWidth: 1920,
    minHeight: 1920,
    quality: 85,
    keepExif: false,
  );

  // 壓縮失敗時 fallback：直接複製原檔
  if (result == null) {
    await File(source.path).copy(destPath);
  }

  return destPath;
}
