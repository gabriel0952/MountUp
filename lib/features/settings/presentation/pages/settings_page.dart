import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('設定', style: theme.textTheme.headlineLarge),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          const SizedBox(height: AppSpacing.s8),
          _SectionHeader(title: '關於'),
          _SettingsTile(
            icon: Icons.info_outline_rounded,
            title: 'MountUp',
            subtitle: '版本 1.0.0',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.terrain_rounded,
            title: '產品理念',
            subtitle: '台灣山友的健行日記',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.s24),
          _SectionHeader(title: '帳號（即將推出）'),
          _SettingsTile(
            icon: Icons.login_rounded,
            title: '登入 / 註冊',
            subtitle: '登入後可雲端同步資料',
            enabled: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s8),
      child: Text(
        title,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: enabled ? 1.0 : 0.4,
      child: Card(
        margin: const EdgeInsets.only(bottom: AppSpacing.s8),
        child: ListTile(
          leading: Icon(icon, color: theme.colorScheme.primary),
          title: Text(title, style: theme.textTheme.titleMedium),
          subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
          trailing: enabled
              ? const Icon(Icons.chevron_right_rounded)
              : null,
          onTap: enabled ? onTap : null,
        ),
      ),
    );
  }
}
