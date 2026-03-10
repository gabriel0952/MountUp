import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/route_entity.dart';
import '../providers/route_provider.dart';
import '../widgets/route_card.dart';

class RoutesListPage extends ConsumerWidget {
  const RoutesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final routesAsync = ref.watch(routeListProvider);
    final filter = ref.watch(routeFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('路線資料庫', style: theme.textTheme.headlineLarge),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          // ── 篩選列 ──────────────────────────────────────────
          _FilterBar(filter: filter),

          // ── 路線列表 ─────────────────────────────────────────
          Expanded(
            child: routesAsync.when(
              loading: () => const _SkeletonList(),
              error: (error, _) => _ErrorView(error: error),
              data: (routes) {
                final filtered = _applyFilter(routes, filter);
                if (filtered.isEmpty) {
                  return const _EmptyView();
                }
                return ListView.separated(
                  padding: AppSpacing.pagePadding
                      .copyWith(top: AppSpacing.s8, bottom: AppSpacing.s32),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.s12),
                  itemBuilder: (context, i) => RouteCard(
                    route: filtered[i],
                    onTap: () => context.push('/routes/${filtered[i].id}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<RouteEntity> _applyFilter(
      List<RouteEntity> routes, RouteFilterState filter) {
    return routes.where((r) {
      final matchDiff =
          filter.difficulty == null || r.difficulty == filter.difficulty;
      final matchRegion =
          filter.region == null || r.region == filter.region;
      return matchDiff && matchRegion;
    }).toList();
  }
}

// ── 篩選列 ─────────────────────────────────────────────────────

class _FilterBar extends ConsumerWidget {
  const _FilterBar({required this.filter});
  final RouteFilterState filter;

  static const _difficulties = [
    (null, '全部'),
    ('easy', '輕鬆'),
    ('moderate', '中等'),
    ('hard', '困難'),
    ('expert', '專家'),
  ];

  static const _regions = [
    (null, '全部'),
    ('北部', '北部'),
    ('中部', '中部'),
    ('南部', '南部'),
    ('東部', '東部'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notifier = ref.read(routeFilterProvider.notifier);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 難度篩選
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s16, vertical: AppSpacing.s4),
            child: Row(
              children: _difficulties.map((entry) {
                final (value, label) = entry;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.s8),
                  child: FilterChip(
                    label: Text(label),
                    selected: filter.difficulty == value,
                    onSelected: (_) => notifier.setDifficulty(value),
                  ),
                );
              }).toList(),
            ),
          ),
          // 地區篩選
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
                left: AppSpacing.s16,
                right: AppSpacing.s16,
                bottom: AppSpacing.s8),
            child: Row(
              children: _regions.map((entry) {
                final (value, label) = entry;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.s8),
                  child: FilterChip(
                    label: Text(label),
                    selected: filter.region == value,
                    onSelected: (_) => notifier.setRegion(value),
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
        ],
      ),
    );
  }
}

// ── Skeleton 載入 ───────────────────────────────────────────────

class _SkeletonList extends StatelessWidget {
  const _SkeletonList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      padding: AppSpacing.pagePadding
          .copyWith(top: AppSpacing.s8, bottom: AppSpacing.s32),
      itemCount: 5,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.s12),
      itemBuilder: (_, _) => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              height: 140,
              color: theme.colorScheme.surfaceContainerHighest,
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 16,
                      width: 180,
                      color: theme.colorScheme.surfaceContainerHighest),
                  const SizedBox(height: AppSpacing.s8),
                  Container(
                      height: 12,
                      width: 100,
                      color: theme.colorScheme.surfaceContainerHighest),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 空狀態 ─────────────────────────────────────────────────────

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.map_rounded,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
          const SizedBox(height: AppSpacing.s16),
          Text('沒有符合條件的路線', style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }
}

// ── 錯誤 / 無快取狀態 ───────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error});
  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNetwork = error is NetworkFailure;
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isNetwork ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
              size: 64,
              color: theme.colorScheme.error.withValues(alpha: 0.6),
            ),
            const SizedBox(height: AppSpacing.s16),
            Text(
              isNetwork ? '請連線以載入路線資料' : '載入路線失敗',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s8),
            Text(
              isNetwork
                  ? '連線後重新開啟此頁面'
                  : error.toString(),
              style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
