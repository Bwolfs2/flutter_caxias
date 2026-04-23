import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:meetup_flutter_caxias/domain/entities/site_copy.dart';

import '../app_data_scope.dart';
import '../router/app_router.dart';
import '../utils/external_link.dart';
import '../widgets/site_content_frame.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDataScope scope = AppDataScope.of(context);
    return FutureBuilder(
      future: scope.communityCopy.fetchSiteCopy(),
      builder: (BuildContext context, AsyncSnapshot<SiteCopy> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              'Não foi possível carregar a página.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        final SiteCopy copy = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.fromLTRB(0, 18, 0, 56),
          children: <Widget>[
            SiteContentFrame(
              child: Column(
                children: <Widget>[
                  _AboutHeroSection(copy: copy),
                  const SizedBox(height: 24),
                  _MissionSection(copy: copy),
                  const SizedBox(height: 32),
                  _ParticipationSection(copy: copy),
                  const SizedBox(height: 32),
                  _CodeOfConductSection(copy: copy),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

final class _AboutHeroSection extends StatelessWidget {
  const _AboutHeroSection({required this.copy});

  final SiteCopy copy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const RadialGradient(
          center: Alignment(0, -0.7),
          radius: 1.25,
          colors: <Color>[
            Color(0xFF1A3258),
            Color(0xFF0B0E14),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 34, 24, 34),
      child: Column(
        children: <Widget>[
          Text(
            'NETWORK SERRA GAÚCHA',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              letterSpacing: 3,
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            copy.aboutIntroTitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.0,
              letterSpacing: -1.1,
            ),
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              copy.aboutIntroBody,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _MissionSection extends StatelessWidget {
  const _MissionSection({required this.copy});
  static const double _cardHeight = 260;

  final SiteCopy copy;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool isNarrow = constraints.maxWidth < 860;
        if (isNarrow) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: _cardHeight,
                child: _InfoCard(
                  title: 'Nossa Missão',
                  body: copy.homeMissionParagraph1,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: _cardHeight,
                child: _ImageHighlightCard(imageUrl: copy.aboutImageUrl),
              ),
            ],
          );
        }
        return SizedBox(
          height: _cardHeight,
          child: Row(
            children: <Widget>[
              Expanded(
                child: _InfoCard(
                  title: 'Nossa Missão',
                  body: copy.homeMissionParagraph1,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ImageHighlightCard(imageUrl: copy.aboutImageUrl),
              ),
            ],
          ),
        );
      },
    );
  }
}

final class _ParticipationSection extends StatelessWidget {
  const _ParticipationSection({required this.copy});

  final SiteCopy copy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          copy.aboutParticipateTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          copy.aboutParticipateBody,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool isNarrow = constraints.maxWidth < 860;
            if (isNarrow) {
              return Column(
                children: <Widget>[
                  _LinkCard(
                    icon: Icons.forum_rounded,
                    title: 'Grupo no Telegram',
                    description:
                        'Discussões rápidas, dúvidas técnicas e networking diário.',
                    actionLabel: 'Entrar no grupo',
                    onTap: () => openExternalLink(
                      context: context,
                      url: _AboutLinks.telegram,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _LinkCard(
                    icon: Icons.event_available_rounded,
                    title: 'Meetups Mensais',
                    description:
                        'Encontros presenciais com talks, cases e sessões de troca.',
                    actionLabel: 'Ver eventos',
                    onTap: () => openExternalLink(
                      context: context,
                      url: copy.meetupUrl,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _LinkCard(
                    icon: Icons.code_rounded,
                    title: 'Contribua no GitHub',
                    description:
                        'Apoie iniciativas da comunidade com issues e PRs.',
                    actionLabel: 'Abrir repositório',
                    onTap: () => openExternalLink(
                      context: context,
                      url: _AboutLinks.githubCommunity,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _LinkCard(
                    icon: Icons.group_work_rounded,
                    title: 'Comunidade',
                    description:
                        'Acesse os canais oficiais e conecte-se com o ecossistema.',
                    actionLabel: 'Abrir seção',
                    onTap: () => context.go(AppRoutePaths.links),
                  ),
                ],
              );
            }
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _LinkCard(
                        icon: Icons.forum_rounded,
                        title: 'Grupo no Telegram',
                        description:
                            'Discussões rápidas, dúvidas técnicas e networking diário.',
                        actionLabel: 'Entrar no grupo',
                        onTap: () => openExternalLink(
                          context: context,
                          url: _AboutLinks.telegram,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: _LinkCard(
                        icon: Icons.event_available_rounded,
                        title: 'Meetups Mensais',
                        description:
                            'Encontros presenciais com talks, cases e sessões de troca.',
                        actionLabel: 'Ver eventos',
                        onTap: () => openExternalLink(
                          context: context,
                          url: copy.meetupUrl,
                        ),
                        imageUrl: copy.aboutImageUrl,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: _LinkCard(
                        icon: Icons.code_rounded,
                        title: 'Contribua no GitHub',
                        description:
                            'Apoie iniciativas da comunidade com issues e PRs.',
                        actionLabel: 'Abrir repositório',
                        onTap: () => openExternalLink(
                          context: context,
                          url: _AboutLinks.githubCommunity,
                        ),
                        imageUrl:
                            'https://images.unsplash.com/photo-1518773553398-650c184e0bb3?w=900&q=80',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _LinkCard(
                        icon: Icons.group_work_rounded,
                        title: 'Comunidade',
                        description:
                            'Acesse os canais oficiais e conecte-se com o ecossistema.',
                        actionLabel: 'Abrir seção',
                        onTap: () => context.go(AppRoutePaths.links),
                        accentColor: const Color(0xFFFFA351),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

final class _CodeOfConductSection extends StatelessWidget {
  const _CodeOfConductSection({required this.copy});

  final SiteCopy copy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.4),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.verified_user_rounded,
                size: 18,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                copy.aboutConductTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            copy.aboutConductBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _CodePill(
                icon: Icons.volunteer_activism_rounded,
                label: 'Sem assédio',
              ),
              _CodePill(
                icon: Icons.forum_rounded,
                label: 'Comunicação respeitosa',
              ),
              _CodePill(
                icon: Icons.diversity_3_rounded,
                label: 'Espaço inclusivo',
              ),
            ],
          ),
          const SizedBox(height: 14),
          FilledButton.tonalIcon(
            onPressed: () => openExternalLink(
              context: context,
              url: copy.flutterCodeOfConductUrl,
            ),
            icon: const Icon(Icons.link_rounded),
            label: const Text('Ler documento completo'),
          ),
        ],
      ),
    );
  }
}

final class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

final class _ImageHighlightCard extends StatelessWidget {
  const _ImageHighlightCard({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace? stackTrace,
            ) {
              return ColoredBox(
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Center(
                  child: Icon(Icons.image_not_supported_outlined),
                ),
              );
            },
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0x00000000),
                  Color(0xCC0B0E14),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Visão 2026',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Tornar a Serra Gaúcha o maior polo de Flutter da região Sul.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _LinkCard extends StatelessWidget {
  const _LinkCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onTap,
    this.imageUrl,
    this.accentColor,
  });

  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onTap;
  final String? imageUrl;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 176),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.35),
        ),
      ),
      child: Stack(
        children: <Widget>[
          if (imageUrl != null)
            Positioned.fill(
              child: IgnorePointer(
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  color: Colors.black.withValues(alpha: 0.42),
                  colorBlendMode: BlendMode.darken,
                  errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                  ) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  size: 16,
                  color: accentColor ?? theme.colorScheme.secondary,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                  label: Text(actionLabel),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _CodePill extends StatelessWidget {
  const _CodePill({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: 14,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

abstract final class _AboutLinks {
  static const String telegram = 'https://t.me/flutterdev';
  static const String githubCommunity = 'https://github.com/flutter/flutter';
}
