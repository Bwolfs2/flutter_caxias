import 'package:meetup_flutter_caxias/data/static_site_constants.dart';
import 'package:meetup_flutter_caxias/domain/datasources/community_social_links_local_data_source.dart';
import 'package:meetup_flutter_caxias/domain/entities/social_link.dart';

final class CommunitySocialLinksLocalDataSourceImpl
    implements CommunitySocialLinksLocalDataSource {
  static final List<SocialLink> _links = <SocialLink>[
    const SocialLink(
      label: 'Meetup (substitua pela URL real)',
      url: StaticSiteConstants.meetupUrl,
      iconKind: SocialLinkIconKind.calendar,
    ),
    const SocialLink(
      label: 'Discord da comunidade',
      url: 'https://discord.com/channels/seu-convite',
      iconKind: SocialLinkIconKind.chat,
    ),
    const SocialLink(
      label: 'Canal no YouTube',
      url: 'https://www.youtube.com/@seu-canal',
      iconKind: SocialLinkIconKind.play,
    ),
    const SocialLink(
      label: 'GitHub da comunidade',
      url: 'https://github.com/seu-org',
      iconKind: SocialLinkIconKind.code,
    ),
    const SocialLink(
      label: 'LinkedIn',
      url: 'https://www.linkedin.com/company/seu-perfil',
      iconKind: SocialLinkIconKind.work,
    ),
  ];

  @override
  Future<List<SocialLink>> fetchSocialLinks() async =>
      List<SocialLink>.unmodifiable(_links);
}
