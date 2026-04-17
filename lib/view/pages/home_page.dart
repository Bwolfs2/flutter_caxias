import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:meetup_flutter_caxias/domain/entities/community_event.dart';
import 'package:meetup_flutter_caxias/domain/entities/site_copy.dart';

import '../app_data_scope.dart';
import '../formatting/event_date_pt.dart';
import '../router/app_router.dart';
import '../theme/app_theme.dart';
import '../utils/external_link.dart';
import '../widgets/gradient_cta_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<({SiteCopy copy, List<CommunityEvent> events})> _loadHome(
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
      future: _loadHome(scope),
      builder: (
        BuildContext context,
        AsyncSnapshot<({SiteCopy copy, List<CommunityEvent> events})> snapshot,
      ) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(48),
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              'Não foi possível carregar a página inicial.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        final SiteCopy copy = snapshot.data!.copy;
        final List<CommunityEvent> events = snapshot.data!.events;
        return _HomeLandingBody(copy: copy, events: events);
      },
    );
  }
}

final class _HomeLandingBody extends StatelessWidget {
  const _HomeLandingBody({
    required this.copy,
    required this.events,
  });

  final SiteCopy copy;
  final List<CommunityEvent> events;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 24),
          _HeroSection(copy: copy),
          const SizedBox(height: 56),
          _AboutSection(copy: copy),
          const SizedBox(height: 56),
          _FeatureCardsRow(copy: copy),
          const SizedBox(height: 56),
          if (events.isNotEmpty) _FeaturedEventCard(event: events.first),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

final class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.copy});

  final SiteCopy copy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return Column(
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: colors.primary.withValues(alpha: 0.55),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              copy.homeBadge,
              style: theme.textTheme.labelLarge?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        Semantics(
          header: true,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: <Widget>[
              Text(
                copy.heroTitleLead,
                textAlign: TextAlign.center,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colors.onSurface,
                  height: 1.05,
                ),
              ),
              const SizedBox(width: 10),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) =>
                    brandTitleGradient().createShader(bounds),
                child: Text(
                  copy.heroTitleAccent,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            copy.homeTagline,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            GradientCtaButton(
              label: 'Ver eventos',
              onPressed: () => context.go(AppRoutePaths.events),
            ),
            OutlinedButton(
              onPressed: () => context.go(AppRoutePaths.links),
              child: const Text('Links da comunidade'),
            ),
          ],
        ),
      ],
    );
  }
}

final class _AboutSection extends StatelessWidget {
  const _AboutSection({required this.copy});

  final SiteCopy copy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.sizeOf(context).width;
    final bool twoCol = width >= 880;
    final Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: twoCol ? 4 / 3 : 16 / 9,
        child: Image.network(
          copy.aboutImageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? progress,
          ) {
            if (progress == null) {
              return child;
            }
            return const ColoredBox(
              color: Color(0xFF161B22),
              child: Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return ColoredBox(
              color: theme.colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 48,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            );
          },
        ),
      ),
    );
    final Widget textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          copy.homeMissionTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          copy.homeMissionParagraph1,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          copy.homeMissionParagraph2,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
    if (twoCol) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 5, child: image),
          const SizedBox(width: 36),
          Expanded(flex: 5, child: textBlock),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        image,
        const SizedBox(height: 24),
        textBlock,
      ],
    );
  }
}

final class _FeatureCardsRow extends StatelessWidget {
  const _FeatureCardsRow({required this.copy});

  final SiteCopy copy;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool row = width >= 720;
    final List<Widget> cards = <Widget>[
      Expanded(
        child: _FeatureCard(
          icon: Icons.groups_2_outlined,
          iconBackground: const Color(0xFF2563EB),
          title: copy.featureNetworkingTitle,
          body: copy.featureNetworkingBody,
        ),
      ),
      SizedBox(width: row ? 20 : 0, height: row ? 0 : 16),
      Expanded(
        child: _FeatureCard(
          icon: Icons.school_outlined,
          iconBackground: const Color(0xFFB45309),
          title: copy.featureLearningTitle,
          body: copy.featureLearningBody,
        ),
      ),
    ];
    if (row) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: cards,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _FeatureCard(
          icon: Icons.groups_2_outlined,
          iconBackground: const Color(0xFF2563EB),
          title: copy.featureNetworkingTitle,
          body: copy.featureNetworkingBody,
        ),
        const SizedBox(height: 16),
        _FeatureCard(
          icon: Icons.school_outlined,
          iconBackground: const Color(0xFFB45309),
          title: copy.featureLearningTitle,
          body: copy.featureLearningBody,
        ),
      ],
    );
  }
}

final class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.iconBackground,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color iconBackground;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              body,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _FeaturedEventCard extends StatelessWidget {
  const _FeaturedEventCard({required this.event});

  final CommunityEvent event;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String dateChip = formatEventDayMonthPt(event.date);
    final Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: event.coverImageUrl != null
            ? Image.network(
                event.coverImageUrl!,
                fit: BoxFit.cover,
                errorBuilder:
                    (BuildContext context, Object e, StackTrace? s) =>
                        _eventPlaceholder(theme),
              )
            : _eventPlaceholder(theme),
      ),
    );
    final Widget details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            _DateChip(label: dateChip),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.place_outlined,
                  size: 18,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    event.locationLabel ?? 'Caxias do Sul, RS',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          event.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          event.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        if (event.registrationUrl != null)
          GradientCtaButton(
            label: 'Abrir página do evento',
            trailingIcon: Icons.arrow_forward,
            onPressed: () => openExternalLink(
              context: context,
              url: event.registrationUrl!,
            ),
          ),
      ],
    );
    final double w = MediaQuery.sizeOf(context).width;
    if (w >= 900) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 5, child: image),
              const SizedBox(width: 28),
              Expanded(flex: 6, child: details),
            ],
          ),
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            image,
            const SizedBox(height: 20),
            details,
          ],
        ),
      ),
    );
  }

  Widget _eventPlaceholder(ThemeData theme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            theme.colorScheme.primary.withValues(alpha: 0.35),
            theme.colorScheme.surfaceContainerHighest,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.event,
          size: 56,
          color: theme.colorScheme.primary.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}

final class _DateChip extends StatelessWidget {
  const _DateChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
