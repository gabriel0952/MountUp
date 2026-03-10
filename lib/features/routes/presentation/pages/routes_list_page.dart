import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';

class RoutesListPage extends StatelessWidget {
  const RoutesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('路線資料庫', style: theme.textTheme.headlineLarge),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.map_rounded,
                size: 72,
                color: theme.colorScheme.primary.withValues(alpha: 0.4),
              ),
              const SizedBox(height: AppSpacing.s16),
              Text('路線資料庫', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.s8),
              Text(
                'Milestone 4 開發中',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
