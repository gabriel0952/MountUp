import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'core/constants/app_theme.dart';
import 'core/constants/env.dart';
import 'routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Mapbox access token（pk.* 公開 token）
  MapboxOptions.setAccessToken(Env.mapboxToken);

  // flutter_foreground_task 通訊埠初始化
  FlutterForegroundTask.initCommunicationPort();

  runApp(const ProviderScope(child: MountUpApp()));
}

class MountUpApp extends StatelessWidget {
  const MountUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title:        'MountUp',
      theme:        buildLightTheme(),
      darkTheme:    buildDarkTheme(),
      themeMode:    ThemeMode.system,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
