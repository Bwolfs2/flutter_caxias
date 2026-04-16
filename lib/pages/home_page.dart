import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/community_content.dart';
import '../data/events_data.dart';
import '../domain/community_event.dart';
import '../router/app_router.dart';
import '../utils/external_link.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Semantics(
            header: true,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: <Color>[
                    colors.primary,
                    colors.primary.withValues(alpha: 0.75),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      CommunityContent.siteTitle,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      CommunityContent.homeTagline,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onPrimary.withValues(alpha: 0.95),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: <Widget>[
                        FilledButton(
                          onPressed: () => context.go(AppRoutePaths.events),
                          style: FilledButton.styleFrom(
                            backgroundColor: colors.onPrimary,
                            foregroundColor: colors.primary,
                          ),
                          child: const Text('Ver eventos'),
                        ),
                        OutlinedButton(
                          onPressed: () => context.go(AppRoutePaths.links),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: colors.onPrimary,
                            side: BorderSide(color: colors.onPrimary.withValues(alpha: 0.85)),
                          ),
                          child: const Text('Links da comunidade'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            CommunityContent.homeMissionTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            CommunityContent.homeMissionBody,
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
          const SizedBox(height: 28),
          if (kCommunityEvents.isNotEmpty) _NextEventCard(event: kCommunityEvents.first),
        ],
      ),
    );
  }
}

class _NextEventCard extends StatelessWidget {
  const _NextEventCard({required this.event});

  final CommunityEvent event;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MaterialLocalizations locale = MaterialLocalizations.of(context);
    final DateTime localDate = event.date.toLocal();
    final String dateLabel = locale.formatFullDate(localDate);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Próximo destaque',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              event.title,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(dateLabel),
            if (event.locationLabel != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(event.locationLabel!),
            ],
            const SizedBox(height: 12),
            Text(
              event.description,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
            ),
            if (event.registrationUrl != null) ...<Widget>[
              const SizedBox(height: 16),
              FilledButton.tonalIcon(
                onPressed: () => openExternalLink(
                  context: context,
                  url: event.registrationUrl!,
                ),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Abrir página do evento'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
