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
import '../../../activity/domain/repositories/activity_repository.dart';
import '../providers/activity_provider.dart';
import '../providers/photo_provider.dart';

const _kHeroHeight = 260.0;

class ActivityDetailPage extends ConsumerStatefulWidget {
  const ActivityDetailPage({super.key, required this.activityId});
  final String activityId;

  @override
  ConsumerState<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends ConsumerState<ActivityDetailPage> {
  // ── ScrollController for AppBar transparency ──────────────
  final _scrollController = ScrollController();
  bool _appBarScrolled = false;

  // ── 名稱/日期 editing state ──────────────────────────────
  bool _editingInfo = false;
  late TextEditingController _titleController;
  DateTime? _editingDate;

  // ── 筆記 editing state ───────────────────────────────────
  bool _editingNotes = false;
  late TextEditingController _notesController;

  // ── Activity ref ─────────────────────────────────────────
  bool _initialized = false;
  Activity? _activity;

  // ── Map ──────────────────────────────────────────────────
  MapboxMap? _mapboxMap;
  PolylineAnnotationManager? _trackManager;
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _notesController = TextEditingController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onScroll() {
    const threshold = 200.0;
    final scrolled = _scrollController.offset > threshold;
    if (scrolled != _appBarScrolled) setState(() => _appBarScrolled = scrolled);
  }

  void _initControllers(Activity activity) {
    if (_initialized) return;
    _initialized = true;
    _activity = activity;
    _titleController.text = activity.title;
    _notesController.text = activity.notes ?? '';
    _editingDate = activity.date;
  }

  // ── 名稱/日期 ────────────────────────────────────────────

  Future<void> _saveInfo() async {
    final activity = _activity;
    if (activity == null) return;
    await ref.read(activityRepositoryProvider).save(
          ActivitiesCompanion(
            id: Value(activity.id),
            title: Value(_titleController.text.trim().isEmpty
                ? activity.title
                : _titleController.text.trim()),
            date: Value(_editingDate ?? activity.date),
            updatedAt: Value(DateTime.now()),
          ),
        );
    ref.invalidate(activityListProvider);
    if (mounted) setState(() => _editingInfo = false);
  }

  void _cancelInfo() {
    final activity = _activity;
    if (activity == null) return;
    _titleController.text = activity.title;
    setState(() {
      _editingDate = activity.date;
      _editingInfo = false;
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _editingDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _editingDate = picked);
  }

  // ── 筆記 ─────────────────────────────────────────────────

  Future<void> _saveNotes() async {
    final activity = _activity;
    if (activity == null) return;
    await ref.read(activityRepositoryProvider).save(
          ActivitiesCompanion(
            id: Value(activity.id),
            title: Value(activity.title),
            date: Value(activity.date),
            notes: Value(_notesController.text.trim().isEmpty
                ? null
                : _notesController.text.trim()),
            updatedAt: Value(DateTime.now()),
          ),
        );
    ref.invalidate(activityListProvider);
    if (mounted) {
      setState(() => _editingNotes = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('筆記已儲存'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _cancelNotes() {
    _notesController.text = _activity?.notes ?? '';
    setState(() => _editingNotes = false);
  }

  // ── 地圖 ─────────────────────────────────────────────────

  Future<void> _onMapCreated(MapboxMap map) async {
    _mapboxMap = map;
    _trackManager = await map.annotations.createPolylineAnnotationManager();
    _mapReady = true;
    if (_activity?.trackJson != null) await _drawTrack(_activity!.trackJson!);
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
        lineColor: const Color(0xFFFF5722).toARGB32(),
        lineWidth: 3.5,
        lineJoin: LineJoin.ROUND,
      ),
    );

    final lats = points.map((p) => p.lat);
    final lngs = points.map((p) => p.lng);
    final sw = Position(lngs.reduce((a, b) => a < b ? a : b),
        lats.reduce((a, b) => a < b ? a : b));
    final ne = Position(lngs.reduce((a, b) => a > b ? a : b),
        lats.reduce((a, b) => a > b ? a : b));

    await _mapboxMap
        ?.cameraForCoordinateBounds(
          CoordinateBounds(
              southwest: Point(coordinates: sw),
              northeast: Point(coordinates: ne),
              infiniteBounds: false),
          MbxEdgeInsets(top: 32, left: 32, bottom: 32, right: 32),
          null,
          null,
          null,
          null,
        )
        .then((camera) => _mapboxMap?.setCamera(camera));
  }

  // ── 照片 ─────────────────────────────────────────────────

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
    await ref.read(photoRepositoryProvider).save(
          ActivityPhotosCompanion.insert(
            activityId: widget.activityId,
            localPath: localPath,
            takenAt: Value(DateTime.now()),
          ),
        );
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
              child: const Text('取消')),
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
              child: const Text('取消')),
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

    final photos =
        await ref.read(photoRepositoryProvider).getByActivityId(activity.id);
    for (final p in photos) {
      await ref.read(photoRepositoryProvider).delete(p.id);
    }
    _activity = null;
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

    final activitiesAsync = ref.watch(activityListProvider);

    return activitiesAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (activities) {
        final activity =
            activities.where((a) => a.id == widget.activityId).firstOrNull;
        if (activity == null) {
          return const Scaffold(body: Center(child: Text('找不到活動')));
        }

        _initControllers(activity);
        _activity = activity;

        final duration = activity.durationS != null
            ? Duration(seconds: activity.durationS!)
            : null;
        final hasTrack = activity.trackJson != null;

        // AppBar colours change based on scroll position
        final fgColor =
            _appBarScrolled ? theme.colorScheme.onSurface : Colors.white;

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: _appBarScrolled
                ? theme.scaffoldBackgroundColor.withValues(alpha: 0.96)
                : Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: fgColor,
            title: _appBarScrolled
                ? Text(
                    activity.title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: fgColor, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            actions: [
              IconButton(
                icon: Icon(Icons.ios_share_rounded, color: fgColor),
                onPressed: () =>
                    context.push('/activities/${widget.activityId}/share'),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: _appBarScrolled
                      ? theme.colorScheme.error
                      : Colors.white,
                ),
                onPressed: () => _deleteActivity(activity),
              ),
            ],
          ),
          body: ListView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            children: [
              // ── Hero (地圖 or 佔位背景) ──────────────────
              _HeroSection(
                hasTrack: hasTrack,
                isDark: isDark,
                primary: primary,
                onMapCreated: _onMapCreated,
              ),

              // ── 主要內容 ────────────────────────────────
              Padding(
                padding: AppSpacing.pagePadding
                    .copyWith(top: AppSpacing.s20, bottom: AppSpacing.s32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 名稱 / 日期
                    _InfoSection(
                      activity: activity,
                      editing: _editingInfo,
                      titleController: _titleController,
                      editingDate: _editingDate ?? activity.date,
                      onEdit: () => setState(() {
                        _titleController.text = activity.title;
                        _editingDate = activity.date;
                        _editingInfo = true;
                      }),
                      onSave: _saveInfo,
                      onCancel: _cancelInfo,
                      onPickDate: _pickDate,
                    ),

                    const SizedBox(height: AppSpacing.s20),

                    // 統計
                    _StatsCard(
                        activity: activity,
                        duration: duration,
                        primary: primary),

                    const SizedBox(height: AppSpacing.s24),

                    // 照片
                    _SectionRow(
                      title: '照片',
                      trailing: TextButton.icon(
                        onPressed: _addPhoto,
                        icon: const Icon(
                            Icons.add_photo_alternate_rounded,
                            size: 16),
                        label: const Text('新增'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    _PhotoGrid(
                      activityId: widget.activityId,
                      onDelete: _deletePhoto,
                    ),

                    const SizedBox(height: AppSpacing.s24),

                    // 筆記
                    _NotesSection(
                      activity: activity,
                      editing: _editingNotes,
                      controller: _notesController,
                      onEdit: () => setState(() {
                        _notesController.text = activity.notes ?? '';
                        _editingNotes = true;
                      }),
                      onSave: _saveNotes,
                      onCancel: _cancelNotes,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Hero Section
// ─────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.hasTrack,
    required this.isDark,
    required this.primary,
    required this.onMapCreated,
  });

  final bool hasTrack;
  final bool isDark;
  final Color primary;
  final void Function(MapboxMap) onMapCreated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kHeroHeight,
      child: Stack(
        children: [
          // Background: map or gradient placeholder
          Positioned.fill(
            child: hasTrack
                ? MapWidget(
                    styleUri: MapboxStyles.OUTDOORS,
                    onMapCreated: onMapCreated,
                  )
                : _GradientPlaceholder(isDark: isDark, primary: primary),
          ),
          // Top-to-bottom gradient for AppBar icon readability
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 110,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x66000000), Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientPlaceholder extends StatelessWidget {
  const _GradientPlaceholder({required this.isDark, required this.primary});
  final bool isDark;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [AppColors.darkPrimaryContainer, AppColors.darkSurfaceVariant]
              : [AppColors.lightPrimaryContainer, AppColors.lightSurfaceVariant],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.terrain_rounded,
          size: 88,
          color: primary.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Info Section (name + date)
// ─────────────────────────────────────────────────────────────

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.activity,
    required this.editing,
    required this.titleController,
    required this.editingDate,
    required this.onEdit,
    required this.onSave,
    required this.onCancel,
    required this.onPickDate,
  });

  final Activity activity;
  final bool editing;
  final TextEditingController titleController;
  final DateTime editingDate;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onPickDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!editing) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.s4),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded,
                        size: 13,
                        color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: AppSpacing.s4),
                    Text(
                      activity.date.toDisplayDate(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_rounded, size: 18),
            tooltip: '編輯名稱與日期',
            onPressed: onEdit,
          ),
        ],
      );
    }

    // ── 編輯模式 ──────────────────────────────────────────
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: titleController,
          autofocus: true,
          textInputAction: TextInputAction.done,
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: '活動名稱',
            border:
                OutlineInputBorder(borderRadius: AppRadius.mdBorder),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        OutlinedButton.icon(
          onPressed: onPickDate,
          icon: const Icon(Icons.calendar_today_rounded, size: 15),
          label: Text(editingDate.toDisplayDate()),
          style: OutlinedButton.styleFrom(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
            shape:
                RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
          ),
        ),
        const SizedBox(height: AppSpacing.s12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: onCancel,
              icon: const Icon(Icons.close_rounded, size: 16),
              label: const Text('取消'),
            ),
            const SizedBox(width: AppSpacing.s8),
            FilledButton.icon(
              onPressed: onSave,
              icon: const Icon(Icons.check_rounded, size: 16),
              label: const Text('儲存'),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Stats Card (3-cell horizontal)
// ─────────────────────────────────────────────────────────────

class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.activity,
    required this.duration,
    required this.primary,
  });

  final Activity activity;
  final Duration? duration;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cells = <Widget>[
      _StatCell(
        icon: Icons.straighten_rounded,
        value: (activity.distanceKm ?? 0).toStringAsFixed(2),
        unit: 'km',
        label: '距離',
        primary: primary,
      ),
      _StatCell(
        icon: Icons.trending_up_rounded,
        value: '${activity.elevationM ?? 0}',
        unit: 'm',
        label: '累積爬升',
        primary: primary,
      ),
      if (duration != null)
        _StatCell(
          icon: Icons.timer_rounded,
          value: duration!.toHHMM(),
          unit: '',
          label: '移動時間',
          primary: primary,
        ),
    ];

    final divider = VerticalDivider(
      width: 1,
      thickness: 1,
      color: theme.dividerColor,
      indent: AppSpacing.s12,
      endIndent: AppSpacing.s12,
    );

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: AppRadius.lgBorder,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (int i = 0; i < cells.length; i++) ...[
              if (i > 0) divider,
              Expanded(child: cells[i]),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
    required this.primary,
  });

  final IconData icon;
  final String value;
  final String unit;
  final String label;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.s16, horizontal: AppSpacing.s12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: primary),
          const SizedBox(height: AppSpacing.s8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
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
          const SizedBox(height: AppSpacing.s2),
          Text(
            label,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Notes Section
// ─────────────────────────────────────────────────────────────

class _NotesSection extends StatelessWidget {
  const _NotesSection({
    required this.activity,
    required this.editing,
    required this.controller,
    required this.onEdit,
    required this.onSave,
    required this.onCancel,
  });

  final Activity activity;
  final bool editing;
  final TextEditingController controller;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasNotes = activity.notes?.isNotEmpty == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header row
        Row(
          children: [
            Expanded(
              child: Text(
                '筆記',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            if (!editing)
              IconButton(
                icon: const Icon(Icons.edit_rounded, size: 18),
                tooltip: '編輯筆記',
                onPressed: onEdit,
              )
            else ...[
              TextButton.icon(
                onPressed: onCancel,
                icon: const Icon(Icons.close_rounded, size: 16),
                label: const Text('取消'),
              ),
              const SizedBox(width: AppSpacing.s4),
              FilledButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.check_rounded, size: 16),
                label: const Text('儲存'),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.s8),

        // Content
        if (!editing)
          hasNotes
              ? Text(activity.notes!, style: theme.textTheme.bodyMedium)
              : Text(
                  '尚未新增筆記，點擊右方 ✏️ 開始撰寫',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                )
        else
          TextField(
            controller: controller,
            maxLines: null,
            minLines: 5,
            autofocus: true,
            decoration: InputDecoration(
              hintText: '記錄這次健行的心得…',
              border: OutlineInputBorder(borderRadius: AppRadius.mdBorder),
              contentPadding: const EdgeInsets.all(AppSpacing.s16),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────

class _SectionRow extends StatelessWidget {
  const _SectionRow({required this.title, this.trailing});
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Photo Grid
// ─────────────────────────────────────────────────────────────

class _PhotoGrid extends ConsumerWidget {
  const _PhotoGrid({required this.activityId, required this.onDelete});

  final String activityId;
  final Future<void> Function(ActivityPhoto) onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(activityPhotosProvider(activityId));
    final theme = Theme.of(context);

    return photosAsync.when(
      loading: () => const SizedBox(
          height: 80, child: Center(child: CircularProgressIndicator())),
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
                '尚無照片，點擊上方「新增」',
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
                  errorBuilder: (_, __, ___) => Container(
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
