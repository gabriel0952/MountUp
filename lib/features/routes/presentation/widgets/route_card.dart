import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/route_entity.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({
    super.key,
    required this.route,
    required this.onTap,
  });

  final RouteEntity route;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 封面圖 ──────────────────────────────────────
            SizedBox(
              height: 140,
              width: double.infinity,
              child: route.coverUrl != null
                  ? Hero(
                      tag: 'route-cover-${route.id}',
                      child: CachedNetworkImage(
                        imageUrl: route.coverUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, _) => Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                        errorWidget: (_, _, _) => _PlaceholderCover(theme: theme),
                      ),
                    )
                  : _PlaceholderCover(theme: theme),
            ),

            // ── 資訊區 ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 標題 + 難度 chip
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          route.name,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (route.difficulty != null) ...[
                        const SizedBox(width: AppSpacing.s8),
                        _DifficultyChip(difficulty: route.difficulty!),
                      ],
                    ],
                  ),

                  if (route.region != null) ...[
                    const SizedBox(height: AppSpacing.s4),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 2),
                        Text(
                          route.region!,
                          style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: AppSpacing.s8),

                  // 距離 + 爬升
                  Row(
                    children: [
                      if (route.distanceKm != null)
                        _StatChip(
                          icon: Icons.straighten_rounded,
                          label: '${route.distanceKm!.toStringAsFixed(1)} km',
                        ),
                      if (route.distanceKm != null && route.elevationM != null)
                        const SizedBox(width: AppSpacing.s8),
                      if (route.elevationM != null)
                        _StatChip(
                          icon: Icons.trending_up_rounded,
                          label: '${route.elevationM} m',
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderCover extends StatelessWidget {
  const _PlaceholderCover({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Container(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(Icons.terrain_rounded,
              size: 48, color: theme.colorScheme.onSurfaceVariant),
        ),
      );
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({required this.difficulty});
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
          horizontal: AppSpacing.s8, vertical: AppSpacing.s2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: AppRadius.smBorder,
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w600, color: color),
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
        Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.s4),
        Text(label,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
