import 'package:meetup_flutter_caxias/data/static_site_constants.dart';
import 'package:meetup_flutter_caxias/domain/datasources/community_events_local_data_source.dart';
import 'package:meetup_flutter_caxias/domain/entities/community_event.dart';

/// Static events — edit dates and URLs before publishing.
final class CommunityEventsLocalDataSourceImpl
    implements CommunityEventsLocalDataSource {
  static final List<CommunityEvent> _events = <CommunityEvent>[
    CommunityEvent(
      title: 'Meetup #0 — Kickoff',
      date: DateTime.utc(2026, 5, 10, 19, 0),
      description:
          'O primeiro encontro oficial. Venha conhecer a curadoria, o espaço '
          'físico e como vamos escalar os meetups na região.',
      locationLabel: 'Caxias do Sul, RS',
      registrationUrl: StaticSiteConstants.meetupUrl,
      coverImageUrl:
          'https://images.unsplash.com/photo-1540575467063-27a517340ca3?w=960&q=80',
    ),
    CommunityEvent(
      title: 'Workshop — Primeiros passos com Dart e Flutter',
      date: DateTime.utc(2026, 6, 14, 14, 0),
      description:
          'Mão na massa para quem está começando: ambiente, widgets e '
          'hot reload.',
      locationLabel: 'Híbrido (presencial + transmissão)',
      registrationUrl: StaticSiteConstants.meetupUrl,
    ),
  ];

  @override
  Future<List<CommunityEvent>> fetchEvents() async =>
      List<CommunityEvent>.unmodifiable(_events);
}
