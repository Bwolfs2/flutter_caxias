import 'package:meetup_flutter_caxias/data/static_site_constants.dart';
import 'package:meetup_flutter_caxias/domain/datasources/community_copy_local_data_source.dart';
import 'package:meetup_flutter_caxias/domain/entities/site_copy.dart';

/// Static institutional copy — edit here before publishing.
final class CommunityCopyLocalDataSourceImpl
    implements CommunityCopyLocalDataSource {
  static const SiteCopy _copy = SiteCopy(
    siteTitle: 'Flutter Caxias',
    homeBadge: 'LUMINOUS NEXUS',
    heroTitleLead: 'Flutter',
    heroTitleAccent: 'Caxias do Sul',
    homeTagline:
        'O ponto de convergência para desenvolvedores, designers e curiosos '
        'na Serra Gaúcha. Conecte-se, aprenda e construa o futuro mobile com a '
        'gente.',
    homeMissionTitle: 'Por que existimos',
    homeMissionParagraph1:
        'Acreditamos que o ecossistema Flutter na região merece um espaço '
        'dedicado para o networking real e a troca técnica de alto nível.',
    homeMissionParagraph2:
        'Nossa missão é conectar talentos locais, startups e grandes empresas, '
        'fomentando um ambiente colaborativo onde o conhecimento flui '
        'organicamente entre os membros.',
    aboutImageUrl:
        'https://images.unsplash.com/photo-1497366216548-375260702cec?w=960&q=80',
    featureNetworkingTitle: 'Networking Real',
    featureNetworkingBody:
        'Conecte-se com profissionais da indústria, encontre oportunidades de '
        'carreira e construa parcerias duradouras fora do ambiente virtual.',
    featureLearningTitle: 'Aprender Juntos',
    featureLearningBody:
        'Palestras técnicas, workshops hands-on e sessões de code review em '
        'grupo para acelerar seu domínio do framework.',
    aboutIntroTitle: 'Sobre a comunidade',
    aboutIntroBody:
        'Somos um grupo independente de pessoas apaixonadas por Flutter. '
        'Organizamos meetups, lives e conteúdos em português para aproximar a '
        'documentação oficial da realidade do dia a dia dos devs.',
    aboutParticipateTitle: 'Como participar',
    aboutParticipateBody:
        'Entre no Meetup (link em Comunidade), confirme presença nos próximos '
        'eventos e traga perguntas ou temas que queira ver na pauta. '
        'Sugerimos também seguir o código de conduta da comunidade Flutter.',
    aboutConductTitle: 'Código de conduta',
    aboutConductBody:
        'Respeito acima de tudo: eventos livres de assédio e discriminação. '
        'O guia oficial do Flutter está no link abaixo.',
    joinCommunityCtaLabel: 'Join Nexus',
    meetupUrl: StaticSiteConstants.meetupUrl,
    flutterCodeOfConductUrl: 'https://flutter.dev/community/code-of-conduct',
    footerCopyrightLine: '© 2026 Flutter Caxias do Sul.',
    footerBuiltLine: 'Built at the Luminous Nexus.',
    footerDocumentationLabel: 'Documentation',
    footerDocumentationUrl: 'https://docs.flutter.dev',
    footerGithubLabel: 'GitHub',
    footerGithubUrl: 'https://github.com/flutter/flutter',
    footerConductLabel: 'Code of Conduct',
    footerPrivacyLabel: 'Privacy Policy',
    footerPrivacyUrl: 'https://policies.google.com/privacy',
  );

  @override
  Future<SiteCopy> fetchSiteCopy() async => _copy;
}
