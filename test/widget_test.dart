import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:meetup_flutter_caxias/app.dart';
import 'package:meetup_flutter_caxias/router/app_router.dart';

void main() {
  testWidgets('shows Flutter Caxias branding', (WidgetTester tester) async {
    final GoRouter router = createAppRouter();
    await tester.pumpWidget(MeetupFlutterCaxiasApp(router: router));
    await tester.pump();
    expect(find.textContaining('Flutter Caxias'), findsWidgets);
  });
}
