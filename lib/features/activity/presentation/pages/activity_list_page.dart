import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../providers/activity_provider.dart';
import '../widgets/activity_card.dart';

class ActivityListPage extends ConsumerWidget {
  const ActivityListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final activitiesAsync = ref.watch(activityListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('MountUp', style: theme.textTheme.headlineLarge),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: activitiesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (activities) => activities.isEmpty
            ? _EmptyState()
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s16,
                  vertical: AppSpacing.s12,
                ),
                itemCount: activities.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.s12),
                itemBuilder: (context, i) => ActivityCard(
                  activity: activities[i],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/tracking'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.play_arrow_rounded, size: 28),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.terrain_rounded,
              size: 72,
              color: theme.colorScheme.primary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: AppSpacing.s16),
            Text('尚無健行紀錄', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSpacing.s8),
            Text(
              '點擊右下角按鈕開始第一次健行',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
