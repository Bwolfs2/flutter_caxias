import '../entities/community_event.dart';

abstract interface class CommunityEventsLocalDataSource {
  Future<List<CommunityEvent>> fetchEvents();
}
