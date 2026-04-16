import 'package:flutter/material.dart';

import '../data/events_data.dart';
import '../domain/community_event.dart';
import '../utils/external_link.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MaterialLocalizations locale = MaterialLocalizations.of(context);
    if (kCommunityEvents.isEmpty) {
      return Center(
        child: Text(
          'Nenhum evento cadastrado. Adicione entradas em lib/data/events_data.dart.',
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.separated(
      itemCount: kCommunityEvents.length + 1,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Próximos encontros',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }
        final CommunityEvent event = kCommunityEvents[index - 1];
        final DateTime localDate = event.date.toLocal();
        final String dateLabel = locale.formatFullDate(localDate);
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.icon(
                      onPressed: () => openExternalLink(
                        context: context,
                        url: event.registrationUrl!,
                      ),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Inscrição / detalhes'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
