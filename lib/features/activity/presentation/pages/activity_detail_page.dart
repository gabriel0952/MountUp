import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide ImageSource;

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/extensions/datetime_ext.dart';
import '../../../../core/extensions/duration_ext.dart';
import '../../../../core/utils/photo_utils.dart';
import '../../../tracking/domain/entities/track_point.dart';
import '../providers/activity_provider.dart';
import '../providers/photo_provider.dart';

class ActivityDetailPage extends ConsumerStatefulWidget {
  const ActivityDetailPage({super.key, required this.activityId});

  final String activityId;

  @override
  ConsumerState<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends ConsumerState<ActivityDetailPage> {
  late TextEditingController _notesController;
  Timer? _debounce;
  Activity? _activity;

  MapboxMap? _mapboxMap;
  PolylineAnnotationManager? _trackManager;
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    // 離頁強制 flush 筆記
    if (_activity != null) {
      ref.read(activityRepositoryProvider).save(
            ActivitiesCompanion(
              id: Value(_activity!.id),
              title: Value(_activity!.title),
              date: Value(_activity!.date),
              notes: Value(_notesController.text.trim().isEmpty
                  ? null
                  : _notesController.text.trim()),
              updatedAt: Value(DateTime.now()),
            ),
          );
    }
    _notesController.dispose();
    super.dispose();
  }

  void _onNotesChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      if (_activity == null) return;
      ref.read(activityRepositoryProvider).save(
            ActivitiesCompanion(
              id: Value(_activity!.id),
              title: Value(_activity!.title),
              date: Value(_activity!.date),
              notes:
                  Value(value.trim().isEmpty ? null : value.trim()),
              updatedAt: Value(DateTime.now()),
            ),
          );
    });
  }

  // ── 地圖 ──────────────────────────────────────────────────

  Future<void> _onMapCreated(MapboxMap map) async {
    _mapboxMap = map;
    _trackManager =
        await map.annotations.createPolylineAnnotationManager();
    _mapReady = true;
    if (_activity?.trackJson != null) {
      await _drawTrack(_activity!.trackJson!);
    }
  }

  Future<void> _drawTrack(String trackJson) async {
    if (!_mapReady || _trackManager == null) return;
    final raw = jsonDecode(trackJson) as List;
    final points =
        raw.map((e) => TrackPoint.fromJson(e as Map<String, dynamic>)).toList();
    if (points.length < 2) return;

    final coords = points.map((p) => Position(p.lng, p.lat)).toList();
    await _trackManager!.deleteAll();
    await _trackManager!.create(
      PolylineAnnotationOptions(
        geometry: LineString(coordinates: coords),
        lineColor: const Color(0xFF4CAF82).toARGB32(),
        lineWidth: 3.5,
        lineJoin: LineJoin.ROUND,
      ),
    );

    // 自動 fit bounding box
    final lats = points.map((p) => p.lat);
    final lngs = points.map((p) => p.lng);
    final sw = Position(lngs.reduce((a, b) => a < b ? a : b),
        lats.reduce((a, b) => a < b ? a : b));
    final ne = Position(lngs.reduce((a, b) => a > b ? a : b),
        lats.reduce((a, b) => a > b ? a : b));

    await _mapboxMap?.cameraForCoordinateBounds(
      CoordinateBounds(southwest: Point(coordinates: sw),
          northeast: Point(coordinates: ne),
          infiniteBounds: false),
      MbxEdgeInsets(top: 48, left: 48, bottom: 48, right: 48),
      null,
      null,
      null,
      null,
    ).then((camera) => _mapboxMap?.setCamera(camera));
  }

  // ── 照片 ──────────────────────────────────────────────────

  Future<void> _addPhoto() async {
    final picker = ImagePicker();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('拍照'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('從相簿選取'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    final file = await picker.pickImage(source: source);
    if (file == null) return;

    final localPath = await compressAndSave(file);
    final companion = ActivityPhotosCompanion.insert(
      activityId: widget.activityId,
      localPath: localPath,
      takenAt: Value(DateTime.now()),
    );
    await ref.read(photoRepositoryProvider).save(companion);
    ref.invalidate(activityPhotosProvider(widget.activityId));
  }

  Future<void> _deletePhoto(ActivityPhoto photo) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('刪除照片'),
        content: const Text('確定要刪除這張照片嗎？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            child: const Text('刪除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(photoRepositoryProvider).delete(photo.id);
    ref.invalidate(activityPhotosProvider(widget.activityId));
  }

  // ── 刪除活動 ──────────────────────────────────────────────

  Future<void> _deleteActivity(Activity activity) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('刪除活動'),
        content: const Text('確定要刪除這筆活動？照片與紀錄將一併移除，此操作無法復原。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            child: const Text('刪除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    // 刪除所有關聯照片（含檔案）
    final photos = await ref
        .read(photoRepositoryProvider)
        .getByActivityId(activity.id);
    for (final p in photos) {
      await ref.read(photoRepositoryProvider).delete(p.id);
    }

    _debounce?.cancel(); // 取消待寫入的筆記
    _activity = null; // 防止 dispose 時重新寫入

    await ref.read(activityRepositoryProvider).delete(activity.id);
    ref.invalidate(activityListProvider);

    if (mounted) context.go('/activities');
  }

  // ── Build ─────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    // 直接從 activityListProvider 找到對應活動
    final activitiesAsync = ref.watch(activityListProvider);

    return activitiesAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (activities) {
        final activity = activities
            .where((a) => a.id == widget.activityId)
            .firstOrNull;

        if (activity == null) {
          return const Scaffold(body: Center(child: Text('找不到活動')));
        }

        // 初始化 notes controller（只做一次）
        if (_activity == null) {
          _activity = activity;
          _notesController.text = activity.notes ?? '';
          _notesController.addListener(
              () => _onNotesChanged(_notesController.text));
        }

        final duration = activity.durationS != null
            ? Duration(seconds: activity.durationS!)
            : null;
        final hasTrack = activity.trackJson != null;

        return Scaffold(
          appBar: AppBar(
            title: Text(activity.title,
                style: theme.textTheme.titleLarge,
                overflow: TextOverflow.ellipsis),
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.delete_outline_rounded,
                    color: theme.colorScheme.error),
                onPressed: () => _deleteActivity(activity),
              ),
            ],
          ),
          body: ListView(
            padding: AppSpacing.pagePadding
                .copyWith(top: AppSpacing.s12, bottom: AppSpacing.s32),
            children: [
              // ── 統計數據 ────────────────────────────────────
              _StatsGrid(
                  activity: activity, duration: duration, primary: primary),
              const SizedBox(height: AppSpacing.s20),

              // ── 地圖軌跡 ────────────────────────────────────
              if (hasTrack) ...[
                Text('軌跡', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.s8),
                ClipRRect(
                  borderRadius: AppRadius.lgBorder,
                  child: SizedBox(
                    height: 220,
                    child: MapWidget(
                      styleUri: MapboxStyles.OUTDOORS,
                      onMapCreated: _onMapCreated,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.s20),
              ],

              // ── 照片牆 ──────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('照片', style: theme.textTheme.titleMedium),
                  TextButton.icon(
                    onPressed: _addPhoto,
                    icon: const Icon(Icons.add_photo_alternate_rounded,
                        size: 18),
                    label: const Text('新增'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s8),
              _PhotoGrid(
                activityId: widget.activityId,
                onDelete: _deletePhoto,
              ),
              const SizedBox(height: AppSpacing.s20),

              // ── 筆記 ────────────────────────────────────────
              Text('筆記', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.s8),
              TextField(
                controller: _notesController,
                maxLines: null,
                minLines: 5,
                decoration: InputDecoration(
                  hintText: '記錄這次健行的心得…',
                  border: OutlineInputBorder(
                      borderRadius: AppRadius.mdBorder),
                  contentPadding: const EdgeInsets.all(AppSpacing.s16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── 統計數據格子 ──────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  const _StatsGrid(
      {required this.activity,
      required this.duration,
      required this.primary});

  final Activity activity;
  final Duration? duration;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          activity.date.toDisplayDate(),
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.s12),
        Row(
          children: [
            _StatCard(
              icon: Icons.straighten_rounded,
              label: '距離',
              value: (activity.distanceKm ?? 0).toStringAsFixed(2),
              unit: 'km',
              color: primary,
            ),
            const SizedBox(width: AppSpacing.s12),
            _StatCard(
              icon: Icons.trending_up_rounded,
              label: '累積爬升',
              value: '${activity.elevationM ?? 0}',
              unit: 'm',
              color: primary,
            ),
          ],
        ),
        if (duration != null) ...[
          const SizedBox(height: AppSpacing.s12),
          Row(
            children: [
              _StatCard(
                icon: Icons.timer_rounded,
                label: '移動時間',
                value: duration!.toHHMMSS(),
                unit: '',
                color: primary,
              ),
              const SizedBox(width: AppSpacing.s12),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: AppRadius.lgBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: AppSpacing.s8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: theme.textTheme.headlineLarge,
                  ),
                  if (unit.isNotEmpty) ...[
                    const WidgetSpan(child: SizedBox(width: 2)),
                    TextSpan(
                      text: unit,
                      style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
            Text(label,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

// ── 照片牆 ────────────────────────────────────────────────────

class _PhotoGrid extends ConsumerWidget {
  const _PhotoGrid(
      {required this.activityId, required this.onDelete});

  final String activityId;
  final Future<void> Function(ActivityPhoto) onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(activityPhotosProvider(activityId));
    final theme = Theme.of(context);

    return photosAsync.when(
      loading: () =>
          const SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
      error: (e, _) => Text('$e'),
      data: (photos) {
        if (photos.isEmpty) {
          return Container(
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: AppRadius.lgBorder,
            ),
            child: Center(
              child: Text(
                '尚無照片，點擊右上角「新增」',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSpacing.s4,
            mainAxisSpacing: AppSpacing.s4,
          ),
          itemCount: photos.length,
          itemBuilder: (context, i) {
            final photo = photos[i];
            return GestureDetector(
              onLongPress: () => onDelete(photo),
              child: ClipRRect(
                borderRadius: AppRadius.smBorder,
                child: Image.file(
                  File(photo.localPath),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.broken_image_rounded),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
