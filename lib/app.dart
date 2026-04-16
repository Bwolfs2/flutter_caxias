import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/community_content.dart';
import 'theme/app_theme.dart';

class MeetupFlutterCaxiasApp extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  MeetupFlutterCaxiasApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: CommunityContent.siteTitle,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(brightness: Brightness.light),
      darkTheme: buildAppTheme(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
