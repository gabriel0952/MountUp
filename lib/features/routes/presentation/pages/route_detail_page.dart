import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gpx/gpx.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/route_entity.dart';
import '../providers/route_provider.dart';

class RouteDetailPage extends ConsumerWidget {
  const RouteDetailPage({super.key, required this.routeId});

  final String routeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeAsync = ref.watch(routeByIdProvider(routeId));

    return routeAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('載入失敗：$e')),
      ),
      data: (route) => _RouteDetailView(route: route),
    );
  }
}

// ────────────────────────────────────────────────────────────────

class _RouteDetailView extends ConsumerStatefulWidget {
  const _RouteDetailView({required this.route});
  final RouteEntity route;

  @override
  ConsumerState<_RouteDetailView> createState() => _RouteDetailViewState();
}

class _RouteDetailViewState extends ConsumerState<_RouteDetailView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final route = widget.route;
    final gpxAsync = ref.watch(routeGpxProvider(route.id));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── 封面 SliverAppBar ─────────────────────────────
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: route.coverUrl != null
                  ? Hero(
                      tag: 'route-cover-${route.id}',
                      child: CachedNetworkImage(
                        imageUrl: route.coverUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => Container(
                            color: theme.colorScheme.surfaceContainerHighest),
                      ),
                    )
                  : Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.terrain_rounded, size: 80),
                    ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.pagePadding
                  .copyWith(top: AppSpacing.s20, bottom: AppSpacing.s32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── 標題 & 難度 ─────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(route.name,
                            style: theme.textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w700)),
                      ),
                      if (route.difficulty != null) ...[
                        const SizedBox(width: AppSpacing.s8),
                        _DifficultyBadge(difficulty: route.difficulty!),
                      ],
                    ],
                  ),

                  if (route.region != null) ...[
                    const SizedBox(height: AppSpacing.s4),
                    Row(children: [
                      Icon(Icons.location_on_rounded,
                          size: 16,
                          color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: AppSpacing.s4),
                      Text(route.region!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant)),
                    ]),
                  ],

                  const SizedBox(height: AppSpacing.s20),

                  // ── 數據卡片 ─────────────────────────────────
                  Row(children: [
                    if (route.distanceKm != null)
                      Expanded(
                          child: _StatCard(
                              icon: Icons.straighten_rounded,
                              label: '距離',
                              value:
                                  '${route.distanceKm!.toStringAsFixed(1)} km')),
                    if (route.distanceKm != null && route.elevationM != null)
                      const SizedBox(width: AppSpacing.s12),
                    if (route.elevationM != null)
                      Expanded(
                          child: _StatCard(
                              icon: Icons.trending_up_rounded,
                              label: '總爬升',
                              value: '${route.elevationM} m')),
                  ]),

                  // ── GPX 地圖預覽 ─────────────────────────────
                  const SizedBox(height: AppSpacing.s24),
                  Text('路線地圖',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.s12),
                  gpxAsync.when(
                    loading: () => const SizedBox(
                      height: 260,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (_, _) => const SizedBox.shrink(),
                    data: (gpxContent) => gpxContent == null
                        ? const SizedBox.shrink()
                        : _GpxMapPreview(gpxContent: gpxContent),
                  ),

                  // ── 簡介 ─────────────────────────────────────
                  if (route.description != null &&
                      route.description!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.s24),
                    Text('路線介紹',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: AppSpacing.s8),
                    Text(route.description!,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(height: 1.6)),
                  ],

                  const SizedBox(height: AppSpacing.s32),

                  // ── 開始追蹤按鈕 ──────────────────────────────
                  _StartTrackingButton(route: route),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── GPX 地圖預覽 ──────────────────────────────────────────────────

class _GpxMapPreview extends StatefulWidget {
  const _GpxMapPreview({required this.gpxContent});

  final String gpxContent;

  @override
  State<_GpxMapPreview> createState() => _GpxMapPreviewState();
}

class _GpxMapPreviewState extends State<_GpxMapPreview> {
  MapboxMap? _map;
  bool _ready = false;

  Future<void> _onMapCreated(MapboxMap map) async {
    _map = map;
    final mgr = await map.annotations.createPolylineAnnotationManager();

    // compute() isolate 解析 GPX
    final points = await compute(_parseGpx, widget.gpxContent);
    if (points.length < 2 || !mounted) return;

    await mgr.create(PolylineAnnotationOptions(
      geometry: LineString(
          coordinates: points.map((p) => Position(p.$2, p.$1)).toList()),
      lineColor: const Color(0xFFFF5722).toARGB32(),
      lineWidth: 3.5,
      lineJoin: LineJoin.ROUND,
    ));

    // 自動 fit bounding box
    final lats = points.map((p) => p.$1);
    final lngs = points.map((p) => p.$2);
    final bounds = CoordinateBounds(
      southwest: Point(
          coordinates:
              Position(lngs.reduce((a, b) => a < b ? a : b),
                  lats.reduce((a, b) => a < b ? a : b))),
      northeast: Point(
          coordinates:
              Position(lngs.reduce((a, b) => a > b ? a : b),
                  lats.reduce((a, b) => a > b ? a : b))),
      infiniteBounds: false,
    );
    final cam = await _map?.cameraForCoordinateBounds(
      bounds,
      MbxEdgeInsets(top: 40, left: 40, bottom: 40, right: 40),
      null,
      null,
      null,
      null,
    );
    if (cam != null) await _map?.setCamera(cam);

    if (mounted) setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.mdBorder,
      child: SizedBox(
        height: 260,
        child: Stack(
          children: [
            MapWidget(
              onMapCreated: _onMapCreated,
              styleUri: MapboxStyles.OUTDOORS,
            ),
            if (!_ready)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

/// top-level function for compute()
List<(double, double)> _parseGpx(String content) {
  final gpxData = GpxReader().fromString(content);
  return gpxData.trks
      .expand((trk) => trk.trksegs)
      .expand((seg) => seg.trkpts)
      .where((pt) => pt.lat != null && pt.lon != null)
      .map((pt) => (pt.lat!, pt.lon!))
      .toList();
}

// ── 開始追蹤按鈕 ───────────────────────────────────────────────

class _StartTrackingButton extends ConsumerWidget {
  const _StartTrackingButton({required this.route});
  final RouteEntity route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gpxAsync = ref.watch(routeGpxProvider(route.id));

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: () {
          final gpxContent = gpxAsync.when(
            data: (v) => v,
            loading: () => null,
            error: (_, _) => null,
          );
          context.go('/tracking', extra: gpxContent);
        },
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
        ),
        icon: const Icon(Icons.play_arrow_rounded),
        label: const Text('開始追蹤'),
      ),
    );
  }
}

// ── 輔助 widgets ──────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard(
      {required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: AppRadius.mdBorder,
      ),
      child: Row(children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: AppSpacing.s8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant)),
          Text(value,
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ]),
      ]),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  const _DifficultyBadge({required this.difficulty});
  final String difficulty;

  static const _labels = {
    'easy': '輕鬆',
    'moderate': '中等',
    'hard': '困難',
    'expert': '專家',
  };
  static const _colors = {
    'easy': Color(0xFF66BB6A),
    'moderate': Color(0xFFFFA726),
    'hard': Color(0xFFEF5350),
    'expert': Color(0xFF7E57C2),
  };

  @override
  Widget build(BuildContext context) {
    final label = _labels[difficulty] ?? difficulty;
    final color = _colors[difficulty] ?? Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s12, vertical: AppSpacing.s4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: AppRadius.smBorder,
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
