import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view/theme/app_theme.dart';

class MeetupFlutterCaxiasApp extends StatelessWidget {
  const MeetupFlutterCaxiasApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Caxias',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: buildAppTheme(),
      darkTheme: buildAppTheme(),
      routerConfig: router,
    );
  }
}
