import 'community_content.dart';
import '../domain/community_event.dart';

/// Static events — edit dates and URLs before publishing.
final List<CommunityEvent> kCommunityEvents = <CommunityEvent>[
  CommunityEvent(
    title: 'Meetup #0 — Kickoff Flutter Caxias',
    date: DateTime.utc(2026, 5, 10, 19, 0),
    description:
        'Apresentação da comunidade, painel sobre carreira Flutter e '
        'definição da cadência dos encontros.',
    locationLabel: 'Local a confirmar — Caxias do Sul, RS',
    registrationUrl: CommunityContent.meetupUrlPlaceholder,
  ),
  CommunityEvent(
    title: 'Workshop — Primeiros passos com Dart e Flutter',
    date: DateTime.utc(2026, 6, 14, 14, 0),
    description:
        'Mão na massa para quem está começando: ambiente, widgets e '
        'hot reload.',
    locationLabel: 'Híbrido (presencial + transmissão)',
    registrationUrl: CommunityContent.meetupUrlPlaceholder,
  ),
];
