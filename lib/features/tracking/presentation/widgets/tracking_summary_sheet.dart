import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/duration_ext.dart';
import '../../domain/entities/tracking_session_state.dart';

class TrackingSummarySheet extends StatefulWidget {
  const TrackingSummarySheet({
    super.key,
    required this.state,
    required this.onSave,
    required this.onDiscard,
  });

  final TrackingSessionState state;
  final Future<void> Function(String title) onSave;
  final VoidCallback onDiscard;

  @override
  State<TrackingSummarySheet> createState() => _TrackingSummarySheetState();
}

class _TrackingSummarySheetState extends State<TrackingSummarySheet> {
  final _titleController = TextEditingController(text: '健行紀錄');
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    setState(() => _saving = true);
    await widget.onSave(title);
    if (mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s24, AppSpacing.s12, AppSpacing.s24, AppSpacing.s32,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.s20),

            Text('追蹤完成', style: theme.textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.s20),

            // Title input
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '活動名稱',
                border: OutlineInputBorder(
                  borderRadius: AppRadius.smBorder,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s16,
                  vertical: AppSpacing.s12,
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: AppSpacing.s20),

            // Stats grid
            Row(
              children: [
                _StatCard(
                  icon: Icons.straighten_rounded,
                  label: '距離',
                  value: widget.state.distanceKm.toStringAsFixed(2),
                  unit: 'km',
                  color: primary,
                ),
                const SizedBox(width: AppSpacing.s12),
                _StatCard(
                  icon: Icons.timer_rounded,
                  label: '時間',
                  value: Duration(seconds: widget.state.elapsedSeconds)
                      .toHHMMSS(),
                  unit: '',
                  color: primary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s12),
            Row(
              children: [
                _StatCard(
                  icon: Icons.trending_up_rounded,
                  label: '累積爬升',
                  value: widget.state.elevationGainM.toStringAsFixed(0),
                  unit: 'm',
                  color: primary,
                ),
                const SizedBox(width: AppSpacing.s12),
                _StatCard(
                  icon: Icons.place_rounded,
                  label: 'GPS 點數',
                  value: '${widget.state.trackPoints.length}',
                  unit: '點',
                  color: primary,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.s32),

            // Buttons
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save_rounded),
              label: const Text('儲存活動'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.mdBorder),
              ),
            ),
            const SizedBox(height: AppSpacing.s12),
            TextButton(
              onPressed: _saving ? null : widget.onDiscard,
              child: Text(
                '捨棄紀錄',
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          ],
        ),
      ),
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
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  if (unit.isNotEmpty) ...[
                    const WidgetSpan(child: SizedBox(width: 2)),
                    TextSpan(
                      text: unit,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
