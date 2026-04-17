import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app.dart';
import 'data/datasources/community_copy_local_data_source_impl.dart';
import 'data/datasources/community_events_local_data_source_impl.dart';
import 'data/datasources/community_social_links_local_data_source_impl.dart';
import 'data/datasources/youtube_videos_local_data_source_impl.dart';
import 'view/app_data_scope.dart';
import 'view/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final GoRouter appRouter = createAppRouter();
  runApp(
    AppDataScope(
      communityCopy: CommunityCopyLocalDataSourceImpl(),
      communityEvents: CommunityEventsLocalDataSourceImpl(),
      communitySocialLinks: CommunitySocialLinksLocalDataSourceImpl(),
      youtubeVideos: YoutubeVideosLocalDataSourceImpl(),
      child: MeetupFlutterCaxiasApp(router: appRouter),
    ),
  );
}
