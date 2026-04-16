import 'package:flutter/material.dart';

import '../data/community_content.dart';
import '../utils/external_link.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView(
      children: <Widget>[
        Text(
          CommunityContent.aboutIntroTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          CommunityContent.aboutIntroBody,
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 28),
        Text(
          CommunityContent.aboutParticipateTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          CommunityContent.aboutParticipateBody,
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 28),
        Text(
          CommunityContent.aboutConductTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          CommunityContent.aboutConductBody,
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 16),
        FilledButton.tonalIcon(
          onPressed: () => openExternalLink(
            context: context,
            url: CommunityContent.flutterCodeOfConductUrl,
          ),
          icon: const Icon(Icons.gavel_outlined),
          label: const Text('Código de conduta Flutter'),
        ),
      ],
    );
  }
}
