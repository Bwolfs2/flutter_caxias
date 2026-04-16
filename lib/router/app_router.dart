import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/about_page.dart';
import '../pages/events_page.dart';
import '../pages/home_page.dart';
import '../pages/links_page.dart';
import '../pages/videos_page.dart';
import '../widgets/app_shell.dart';

abstract final class AppRoutePaths {
  static const String home = '/';
  static const String about = '/sobre';
  static const String events = '/eventos';
  static const String links = '/links';
  static const String videos = '/videos';
}

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutePaths.home,
    routes: <RouteBase>[
      ShellRoute(
        builder: (
          BuildContext context,
          GoRouterState state,
          Widget child,
        ) {
          return AppShell(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutePaths.home,
            name: 'home',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(child: HomePage());
            },
          ),
          GoRoute(
            path: AppRoutePaths.about,
            name: 'about',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(child: AboutPage());
            },
          ),
          GoRoute(
            path: AppRoutePaths.events,
            name: 'events',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(child: EventsPage());
            },
          ),
          GoRoute(
            path: AppRoutePaths.links,
            name: 'links',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(child: LinksPage());
            },
          ),
          GoRoute(
            path: AppRoutePaths.videos,
            name: 'videos',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(child: VideosPage());
            },
          ),
        ],
      ),
    ],
  );
}
