import 'package:flutter/material.dart';

import 'package:meetup_flutter_caxias/domain/entities/site_copy.dart';
import 'package:meetup_flutter_caxias/domain/entities/social_link.dart';

import '../app_data_scope.dart';
import '../utils/external_link.dart';
import '../widgets/social_link_icon.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDataScope scope = AppDataScope.of(context);
    return FutureBuilder(
      future: Future.wait(<Future<Object>>[
        scope.communityCopy.fetchSiteCopy(),
        scope.communitySocialLinks.fetchSocialLinks(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<Object>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              'Não foi possível carregar os links.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        final List<Object> data = snapshot.data!;
        final SiteCopy copy = data[0] as SiteCopy;
        final List<SocialLink> links = data[1] as List<SocialLink>;
        final ThemeData theme = Theme.of(context);
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: <Widget>[
            Text(
              'Links oficiais',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Atualize os endereços em '
              'lib/data/datasources/community_social_links_local_data_source_impl.dart.',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
            ),
            const SizedBox(height: 16),
            ...links.map(
              (SocialLink link) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(socialLinkIcon(link.iconKind)),
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
            const SizedBox(height: 8),
            Text(
              'Meetup principal: ${copy.meetupUrl}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        );
      },
    );
  }
}
