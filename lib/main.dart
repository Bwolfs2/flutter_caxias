import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app.dart';
import 'router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final GoRouter appRouter = createAppRouter();
  runApp(MeetupFlutterCaxiasApp(router: appRouter));
}
