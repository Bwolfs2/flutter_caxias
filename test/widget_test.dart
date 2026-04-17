import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:meetup_flutter_caxias/app.dart';
import 'package:meetup_flutter_caxias/data/datasources/community_copy_local_data_source_impl.dart';
import 'package:meetup_flutter_caxias/data/datasources/community_events_local_data_source_impl.dart';
import 'package:meetup_flutter_caxias/data/datasources/community_social_links_local_data_source_impl.dart';
import 'package:meetup_flutter_caxias/data/datasources/youtube_videos_local_data_source_impl.dart';
import 'package:meetup_flutter_caxias/view/app_data_scope.dart';
import 'package:meetup_flutter_caxias/view/router/app_router.dart';

void main() {
  testWidgets('shows Flutter Caxias branding', (WidgetTester tester) async {
    final GoRouter router = createAppRouter();
    await tester.pumpWidget(
      AppDataScope(
        communityCopy: CommunityCopyLocalDataSourceImpl(),
        communityEvents: CommunityEventsLocalDataSourceImpl(),
        communitySocialLinks: CommunitySocialLinksLocalDataSourceImpl(),
        youtubeVideos: YoutubeVideosLocalDataSourceImpl(),
        child: MeetupFlutterCaxiasApp(router: router),
      ),
    );
    await tester.pump();
    expect(find.textContaining('Flutter Caxias'), findsWidgets);
  });
}
