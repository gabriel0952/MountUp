import 'package:flutter/material.dart';

import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/extensions/datetime_ext.dart';
import '../../../../core/extensions/duration_ext.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.activity,
    this.onTap,
  });

  final Activity activity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final duration = activity.durationS != null
        ? Duration(seconds: activity.durationS!)
        : null;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.lgBorder),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgBorder,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + date row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      activity.title,
                      style: theme.textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s8),
                  Text(
                    activity.date.toDisplayDate(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s12),
              // Stats row
              Row(
                children: [
                  _StatChip(
                    icon: Icons.straighten_rounded,
                    label:
                        '${(activity.distanceKm ?? 0).toStringAsFixed(2)} km',
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  _StatChip(
                    icon: Icons.trending_up_rounded,
                    label: '${activity.elevationM ?? 0} m',
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  if (duration != null)
                    _StatChip(
                      icon: Icons.timer_rounded,
                      label: duration.toHHMM(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.primary),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
