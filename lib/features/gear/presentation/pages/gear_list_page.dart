import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';

class GearListPage extends StatelessWidget {
  const GearListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('裝備清單', style: theme.textTheme.headlineLarge),
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
                Icons.backpack_rounded,
                size: 72,
                color: theme.colorScheme.primary.withValues(alpha: 0.4),
              ),
              const SizedBox(height: AppSpacing.s16),
              Text('裝備清單', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.s8),
              Text(
                'Milestone 5 開發中',
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
