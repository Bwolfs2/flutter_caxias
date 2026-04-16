import 'package:flutter/material.dart';

import '../data/community_content.dart';
import '../domain/social_link.dart';
import '../utils/external_link.dart';

final List<SocialLink> kSocialLinks = <SocialLink>[
  const SocialLink(
    label: 'Meetup (substitua pela URL real)',
    url: CommunityContent.meetupUrlPlaceholder,
    icon: Icons.calendar_month_outlined,
  ),
  const SocialLink(
    label: 'Discord da comunidade',
    url: 'https://discord.com/channels/seu-convite',
    icon: Icons.chat_bubble_outline,
  ),
  const SocialLink(
    label: 'Canal no YouTube',
    url: 'https://www.youtube.com/@seu-canal',
    icon: Icons.play_circle_outline,
  ),
  const SocialLink(
    label: 'GitHub da comunidade',
    url: 'https://github.com/seu-org',
    icon: Icons.code,
  ),
  const SocialLink(
    label: 'LinkedIn',
    url: 'https://www.linkedin.com/company/seu-perfil',
    icon: Icons.work_outline,
  ),
];

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView(
      children: <Widget>[
        Text(
          'Links oficiais',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Atualize os endereços em lib/pages/links_page.dart (lista kSocialLinks).',
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
        ),
        const SizedBox(height: 16),
        ...kSocialLinks.map(
          (SocialLink link) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(link.icon),
              title: Text(link.label),
              subtitle: Text(
                link.url,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => openExternalLink(context: context, url: link.url),
            ),
          ),
        ),
      ],
    );
  }
}
