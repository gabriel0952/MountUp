import 'package:go_router/go_router.dart';

import '../features/activity/presentation/pages/activity_create_page.dart';
import '../features/activity/presentation/pages/activity_detail_page.dart';
import '../features/activity/presentation/pages/activity_list_page.dart';
import '../features/gear/presentation/pages/gear_list_page.dart';
import '../features/routes/presentation/pages/routes_list_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../features/tracking/presentation/pages/tracking_page.dart';
import 'shell_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: '/activities',
  routes: [
    ShellRoute(
      builder: (context, state, child) => ShellScaffold(child: child),
      routes: [
        GoRoute(
          path: '/activities',
          builder: (context, state) => const ActivityListPage(),
          routes: [
            GoRoute(
              path: 'create',
              builder: (context, state) => const ActivityCreatePage(),
            ),
            GoRoute(
              path: ':id',
              builder: (context, state) => ActivityDetailPage(
                activityId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/routes',
          builder: (context, state) => const RoutesListPage(),
        ),
        GoRoute(
          path: '/gear',
          builder: (context, state) => const GearListPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/tracking',
      builder: (context, state) => const TrackingPage(),
    ),
  ],
);
