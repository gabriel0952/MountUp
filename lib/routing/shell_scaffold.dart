import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScaffold extends StatelessWidget {
  const ShellScaffold({super.key, required this.child});

  final Widget child;

  static const _tabs = [
    ('/activities', Icons.directions_walk_rounded, '活動'),
    ('/routes',     Icons.map_rounded,             '路線'),
    ('/gear',       Icons.backpack_rounded,        '裝備'),
    ('/settings',   Icons.settings_rounded,        '設定'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final idx = _tabs.indexWhere((t) => location.startsWith(t.$1));
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (i) => context.go(_tabs[i].$1),
        destinations: _tabs
            .map((t) => NavigationDestination(icon: Icon(t.$2), label: t.$3))
            .toList(),
      ),
    );
  }
}
