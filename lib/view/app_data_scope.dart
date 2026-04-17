import 'package:flutter/material.dart';
import 'package:meetup_flutter_caxias/domain/datasources/community_copy_local_data_source.dart';
import 'package:meetup_flutter_caxias/domain/datasources/community_events_local_data_source.dart';
import 'package:meetup_flutter_caxias/domain/datasources/community_social_links_local_data_source.dart';
import 'package:meetup_flutter_caxias/domain/datasources/youtube_videos_local_data_source.dart';

/// Composition root wiring: exposes domain datasource contracts to the view tree.
final class AppDataScope extends InheritedWidget {
  const AppDataScope({
    super.key,
    required this.communityCopy,
    required this.communityEvents,
    required this.communitySocialLinks,
    required this.youtubeVideos,
    required super.child,
  });

  final CommunityCopyLocalDataSource communityCopy;
  final CommunityEventsLocalDataSource communityEvents;
  final CommunitySocialLinksLocalDataSource communitySocialLinks;
  final YoutubeVideosLocalDataSource youtubeVideos;

  static AppDataScope of(BuildContext context) {
    final AppDataScope? result =
        context.dependOnInheritedWidgetOfExactType<AppDataScope>();
    assert(result != null, 'AppDataScope not found in widget tree');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant AppDataScope oldWidget) => false;
}
