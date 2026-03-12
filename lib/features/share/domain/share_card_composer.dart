import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../core/database/app_database.dart';
import '../../../core/extensions/datetime_ext.dart';
import '../../../core/extensions/duration_ext.dart';
import '../../tracking/domain/entities/track_point.dart';
import 'share_card_format.dart';

/// 將活動資料合成為分享卡片圖片。
/// 流程：Snapshotter → dart:ui Canvas 疊加軌跡與數據 → ui.Image
class ShareCardComposer {
  ShareCardComposer._();

  static const _trackColor = Color(0xFFFF5722);
  static const _startColor = Color(0xFF4CAF50);
  static const _endColor = Color(0xFFE53935);

  /// 主入口：產生指定格式的分享卡片。
  static Future<ui.Image> compose(
      Activity activity, ShareCardFormat format) async {
    final points = _parseTrack(activity.trackJson);
    final bounds = _computeBounds(points);

    final mapBytes =
        await _snapMap(points, bounds, format.canvasWidth, format.mapHeight);
    final mapImg = await _decodeImage(mapBytes);

    return _paintCard(mapImg, points, bounds, activity, format);
  }

  // ── 軌跡解析 ────────────────────────────────────────────────

  static List<TrackPoint> _parseTrack(String? json) {
    if (json == null || json.isEmpty) return const [];
    try {
      final raw = jsonDecode(json) as List;
      return raw
          .cast<Map<String, dynamic>>()
          .map(TrackPoint.fromJson)
          .toList();
    } catch (_) {
      return const [];
    }
  }

  // ── Bounding box ────────────────────────────────────────────

  static _Bounds _computeBounds(List<TrackPoint> points) {
    if (points.isEmpty) {
      // 台灣全島
      return const _Bounds(
          minLat: 21.8, maxLat: 25.4, minLng: 119.9, maxLng: 122.1);
    }

    double minLat = points.first.lat,
        maxLat = points.first.lat,
        minLng = points.first.lng,
        maxLng = points.first.lng;

    for (final p in points) {
      if (p.lat < minLat) minLat = p.lat;
      if (p.lat > maxLat) maxLat = p.lat;
      if (p.lng < minLng) minLng = p.lng;
      if (p.lng > maxLng) maxLng = p.lng;
    }

    // 避免零範圍（單點）
    if (maxLat - minLat < 0.001) {
      minLat -= 0.005;
      maxLat += 0.005;
    }
    if (maxLng - minLng < 0.001) {
      minLng -= 0.005;
      maxLng += 0.005;
    }

    // 加 15% padding
    const pad = 0.15;
    final latPad = (maxLat - minLat) * pad;
    final lngPad = (maxLng - minLng) * pad;

    return _Bounds(
      minLat: minLat - latPad,
      maxLat: maxLat + latPad,
      minLng: minLng - lngPad,
      maxLng: maxLng + lngPad,
    );
  }

  // ── Snapshotter ─────────────────────────────────────────────

  static Future<Uint8List> _snapMap(List<TrackPoint> points, _Bounds b,
      int width, int height) async {
    final snapshotter = await Snapshotter.create(
      options: MapSnapshotOptions(
        size: Size(width: width.toDouble(), height: height.toDouble()),
        pixelRatio: 1.0,
      ),
    );

    try {
      await snapshotter.style.setStyleURI(MapboxStyles.OUTDOORS);

      // 計算最佳視角
      final cornerPoints = [
        Point(coordinates: Position(b.minLng, b.minLat)),
        Point(coordinates: Position(b.maxLng, b.minLat)),
        Point(coordinates: Position(b.maxLng, b.maxLat)),
        Point(coordinates: Position(b.minLng, b.maxLat)),
      ];
      final camera = await snapshotter.camera(
        coordinates: cornerPoints,
        padding:
            MbxEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
      );
      await snapshotter.setCamera(camera);

      final bytes = await snapshotter.start();
      if (bytes == null) throw Exception('Snapshotter returned null');
      return bytes;
    } finally {
      await snapshotter.dispose();
    }
  }

  static Future<ui.Image> _decodeImage(Uint8List pngBytes) async {
    final codec = await ui.instantiateImageCodec(pngBytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  // ── Canvas 合成 ─────────────────────────────────────────────

  static Future<ui.Image> _paintCard(
    ui.Image mapImg,
    List<TrackPoint> points,
    _Bounds bounds,
    Activity activity,
    ShareCardFormat format,
  ) async {
    final cw = format.canvasWidth.toDouble();
    final ch = format.canvasHeight.toDouble();
    final mh = format.mapHeight.toDouble();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // 1. 地圖底圖
    canvas.drawImage(mapImg, Offset.zero, Paint());

    // 2. 軌跡線 + 起終點
    if (points.length >= 2) {
      _drawPolyline(canvas, points, bounds, cw, mh);
      _drawEndpoints(canvas, points, bounds, cw, mh);
    }

    // 3. 數據疊加層
    _drawDataOverlay(canvas, activity, format, cw, ch, mh);

    final picture = recorder.endRecording();
    return picture.toImage(format.canvasWidth, format.canvasHeight);
  }

  // ── 座標投影（小範圍線性近似）────────────────────────────────

  static Offset _project(
      double lat, double lng, _Bounds b, double w, double h) {
    final centerLat = (b.minLat + b.maxLat) / 2;
    final cosLat = cos(centerLat * pi / 180);
    final lngKm = (b.maxLng - b.minLng) * 111 * cosLat;
    final latKm = (b.maxLat - b.minLat) * 111;

    final double scaleX, scaleY, xOff, yOff;
    if (lngKm / latKm > w / h) {
      scaleX = w / lngKm;
      scaleY = scaleX;
      xOff = 0;
      yOff = (h - latKm * scaleY) / 2;
    } else {
      scaleY = h / latKm;
      scaleX = scaleY;
      yOff = 0;
      xOff = (w - lngKm * scaleX) / 2;
    }

    final x = (lng - b.minLng) * 111 * cosLat * scaleX + xOff;
    final y = h - yOff - (lat - b.minLat) * 111 * scaleY;
    return Offset(x, y);
  }

  static void _drawPolyline(
      Canvas canvas, List<TrackPoint> pts, _Bounds b, double w, double h) {
    final path = Path();
    final first = _project(pts.first.lat, pts.first.lng, b, w, h);
    path.moveTo(first.dx, first.dy);
    for (var i = 1; i < pts.length; i++) {
      final o = _project(pts[i].lat, pts[i].lng, b, w, h);
      path.lineTo(o.dx, o.dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = _trackColor
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  static void _drawEndpoints(
      Canvas canvas, List<TrackPoint> pts, _Bounds b, double w, double h) {
    final start = _project(pts.first.lat, pts.first.lng, b, w, h);
    final end = _project(pts.last.lat, pts.last.lng, b, w, h);
    const r = 8.0;
    final white = Paint()..color = Colors.white;
    final green = Paint()..color = _startColor;
    final red = Paint()..color = _endColor;

    canvas.drawCircle(start, r + 2, white);
    canvas.drawCircle(start, r, green);
    canvas.drawCircle(end, r + 2, white);
    canvas.drawCircle(end, r, red);
  }

  // ── 數據疊加 ────────────────────────────────────────────────

  static void _drawDataOverlay(
    Canvas canvas,
    Activity activity,
    ShareCardFormat format,
    double cw,
    double ch,
    double mh,
  ) {
    final s = format.fontScale;
    final distText = '${(activity.distanceKm ?? 0).toStringAsFixed(1)} km';
    final elevText = '${activity.elevationM ?? 0} m';
    final timeText = activity.durationS != null
        ? Duration(seconds: activity.durationS!).toHHMM()
        : '--';
    final dateText = activity.date.toDisplayDate();

    if (format == ShareCardFormat.square) {
      // 底部 35% 漸層
      final gradTop = mh * 0.65;
      final grad = ui.Gradient.linear(
        Offset(0, gradTop),
        Offset(0, mh),
        [Colors.transparent, const Color(0xCC000000)],
      );
      canvas.drawRect(
        Rect.fromLTWH(0, gradTop, cw, mh - gradTop),
        Paint()..shader = grad,
      );
      _drawTextBlock(
        canvas, activity.title, distText, elevText, timeText, dateText,
        x: 0, y: mh * 0.68, w: cw, h: mh * 0.32, s: s,
      );
    } else {
      // 9:16：下方純色區塊
      canvas.drawRect(
        Rect.fromLTWH(0, mh, cw, ch - mh),
        Paint()..color = const Color(0xFF1A1A1A),
      );
      _drawTextBlock(
        canvas, activity.title, distText, elevText, timeText, dateText,
        x: 0, y: mh, w: cw, h: ch - mh, s: s,
      );
    }
  }

  static void _drawTextBlock(
    Canvas canvas,
    String title,
    String dist,
    String elev,
    String time,
    String date, {
    required double x,
    required double y,
    required double w,
    required double h,
    required double s,
  }) {
    final pad = 24.0 * s;
    double cy = y + pad;

    // 路線名稱
    cy = _drawText(canvas, title,
        x: x + pad, y: cy, maxW: w - pad * 2,
        size: 28 * s, bold: true, color: Colors.white);
    cy += 10 * s;

    // 三欄統計
    final colW = w / 3;
    _drawStatColumn(canvas, dist, '距離',
        x: x, y: cy, w: colW, s: s);
    _drawStatColumn(canvas, elev, '爬升',
        x: x + colW, y: cy, w: colW, s: s);
    _drawStatColumn(canvas, time, '時間',
        x: x + colW * 2, y: cy, w: colW, s: s);
    cy += 64 * s;

    // 日期（左）
    _drawText(canvas, date,
        x: x + pad, y: cy, maxW: w * 0.55,
        size: 15 * s, bold: false, color: const Color(0xFFBBBBBB));

    // MountUp Logo（右）
    _drawText(canvas, 'MountUp',
        x: x + w - pad - 90 * s, y: cy, maxW: 90 * s,
        size: 15 * s, bold: true, color: _trackColor);
  }

  static void _drawStatColumn(
    Canvas canvas,
    String value,
    String label, {
    required double x,
    required double y,
    required double w,
    required double s,
  }) {
    _drawText(canvas, value,
        x: x, y: y, maxW: w,
        size: 26 * s, bold: true, color: Colors.white,
        align: ui.TextAlign.center);
    _drawText(canvas, label,
        x: x, y: y + 32 * s, maxW: w,
        size: 13 * s, bold: false, color: const Color(0xFFAAAAAA),
        align: ui.TextAlign.center);
  }

  /// 繪製一行文字，回傳下一行的 y 位置。
  static double _drawText(
    Canvas canvas,
    String text, {
    required double x,
    required double y,
    required double maxW,
    required double size,
    required bool bold,
    required Color color,
    ui.TextAlign align = ui.TextAlign.left,
  }) {
    final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: align,
      fontFamily: 'sans-serif',
      maxLines: 2,
      ellipsis: '…',
    ))
      ..pushStyle(ui.TextStyle(
        color: color,
        fontSize: size,
        fontWeight: bold ? ui.FontWeight.bold : ui.FontWeight.normal,
      ))
      ..addText(text);

    final para = builder.build()
      ..layout(ui.ParagraphConstraints(width: maxW));
    canvas.drawParagraph(para, Offset(x, y));
    return y + para.height;
  }
}

// ── Value object ─────────────────────────────────────────────

class _Bounds {
  const _Bounds({
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
  });

  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;
}
