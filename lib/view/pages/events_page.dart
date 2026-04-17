import 'package:flutter/material.dart';

import 'package:meetup_flutter_caxias/domain/entities/community_event.dart';
import 'package:meetup_flutter_caxias/domain/entities/site_copy.dart';

import '../app_data_scope.dart';
import '../formatting/event_date_pt.dart';
import '../theme/app_theme.dart';
import '../utils/external_link.dart';
import '../widgets/site_content_frame.dart';

const double _eventCardWidth = 300;
const double _horizontalListGap = 16;
const double _horizontalListPadding = 20;

/// Total height of each horizontal card (must match [ListView] viewport height).
const double _eventCardTotalHeight = 448;

double get _eventImageHeight => _eventCardWidth * 10 / 16;

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  Future<({SiteCopy copy, List<CommunityEvent> events})> _load(
    AppDataScope scope,
  ) async {
    final List<Object> results = await Future.wait<Object>(<Future<Object>>[
      scope.communityCopy.fetchSiteCopy(),
      scope.communityEvents.fetchEvents(),
    ]);
    return (
      copy: results[0] as SiteCopy,
      events: results[1] as List<CommunityEvent>,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppDataScope scope = AppDataScope.of(context);
    return FutureBuilder<({SiteCopy copy, List<CommunityEvent> events})>(
      future: _load(scope),
      builder: (
        BuildContext context,
        AsyncSnapshot<({SiteCopy copy, List<CommunityEvent> events})> snapshot,
      ) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              'Não foi possível carregar os eventos.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        final SiteCopy copy = snapshot.data!.copy;
        final List<CommunityEvent> events = snapshot.data!.events;
        if (events.isEmpty) {
          return SingleChildScrollView(
            child: SiteContentFrame(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _EventsPageHeader(copy: copy),
                    const SizedBox(height: 28),
                    Text(
                      'Nenhum evento cadastrado. Adicione entradas em '
                      'lib/data/datasources/community_events_local_data_source_impl.dart.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SiteContentFrame(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: _EventsPageHeader(copy: copy),
                ),
              ),
              SizedBox(
                height: _eventCardTotalHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(
                    _horizontalListPadding,
                    8,
                    _horizontalListPadding,
                    24,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: events.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: _horizontalListGap),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: _eventCardWidth,
                      height: _eventCardTotalHeight,
                      child: _EventDiscoverCard(event: events[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final class _EventsPageHeader extends StatelessWidget {
  const _EventsPageHeader({required this.copy});

  final SiteCopy copy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const Color pillBorder = Color(0xFF30363D);
    const Color pillText = Color(0xFFB0B0B0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF161B22),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: pillBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              copy.eventsPageBadge,
              style: theme.textTheme.labelSmall?.copyWith(
                color: pillText,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          copy.eventsPageTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
            shadows: <Shadow>[
              Shadow(
                color: Colors.black.withValues(alpha: 0.55),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          copy.eventsPageSubtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: const Color(0xFFB0B0B0),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

final class _EventDiscoverCard extends StatelessWidget {
  const _EventDiscoverCard({required this.event});

  final CommunityEvent event;

  static const Color _cardBg = Color(0xFF1E1E1E);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ({String monthAbbrev, String dayText}) parts =
        eventDateBadgeParts(event.date);
    final String locationUpper =
        (event.locationLabel ?? 'Caxias do Sul, RS').toUpperCase();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(26),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: _eventImageHeight,
              width: _eventCardWidth,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned.fill(
                    child: event.coverImageUrl != null
                        ? Image.network(
                            event.coverImageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (BuildContext context, Object e, StackTrace? s) =>
                                    _imageFallback(theme),
                          )
                        : _imageFallback(theme),
                  ),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: _DateCircleBadge(
                      monthAbbrev: parts.monthAbbrev,
                      dayText: parts.dayText,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.place_outlined,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            locationUpper,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.95,
                              ),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.6,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        event.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFB0B0B0),
                          height: 1.45,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (event.registrationUrl != null) ...<Widget>[
                      const SizedBox(height: 10),
                      _EventRegistrationCta(
                        onPressed: () => openExternalLink(
                          context: context,
                          url: event.registrationUrl!,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageFallback(ThemeData theme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            theme.colorScheme.primary.withValues(alpha: 0.35),
            const Color(0xFF2A2A2A),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.event,
          size: 48,
          color: theme.colorScheme.primary.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}

final class _DateCircleBadge extends StatelessWidget {
  const _DateCircleBadge({
    required this.monthAbbrev,
    required this.dayText,
  });

  final String monthAbbrev;
  final String dayText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            monthAbbrev,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF424242),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
          ),
          Text(
            dayText,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF212121),
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
          ),
        ],
      ),
    );
  }
}

final class _EventRegistrationCta extends StatelessWidget {
  const _EventRegistrationCta({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const Color labelColor = Color(0xFF0F0F0F);
    return Semantics(
      button: true,
      label: 'Inscrição ou detalhes do evento',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(999),
          child: Ink(
            decoration: BoxDecoration(
              gradient: eventListingCtaGradient(),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Inscrição / detalhes',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: labelColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: labelColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
