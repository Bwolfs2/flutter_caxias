import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';
import '../utils/external_link.dart';
import 'gradient_cta_button.dart';

const double _navBreakpoint = 900;

final class SiteHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const SiteHeaderBar({
    super.key,
    required this.siteTitle,
    required this.joinUrl,
    required this.joinLabel,
  });

  final String siteTitle;
  final String joinUrl;
  final String joinLabel;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  void _handleJoinNexus(BuildContext context) {
    openExternalLink(context: context, url: joinUrl);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool showInlineNav = width >= _navBreakpoint;
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: <Widget>[
              _BrandTitle(
                siteTitle: siteTitle,
                onTapHome: () => context.go(AppRoutePaths.home),
              ),
              if (showInlineNav) ...<Widget>[
                const SizedBox(width: 32),
                Expanded(
                  child: _HeaderNavLinks(),
                ),
              ] else
                const Spacer(),
              IconButton(
                tooltip: 'Perfil da comunidade',
                onPressed: () => context.go(AppRoutePaths.links),
                icon: const Icon(Icons.account_circle_outlined, size: 28),
              ),
              const SizedBox(width: 4),
              if (showInlineNav)
                GradientCtaButton(
                  label: joinLabel,
                  onPressed: () => _handleJoinNexus(context),
                )
              else
                FilledButton(
                  onPressed: () => _handleJoinNexus(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: Text(joinLabel),
                ),
              if (!showInlineNav) ...<Widget>[
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Abrir menu',
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: const Icon(Icons.menu),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

final class _BrandTitle extends StatelessWidget {
  const _BrandTitle({
    required this.siteTitle,
    required this.onTapHome,
  });

  final String siteTitle;
  final VoidCallback onTapHome;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapHome,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.flutter_dash,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
          const SizedBox(width: 8),
          Text(
            siteTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
          ),
        ],
      ),
    );
  }
}

final class _HeaderNavLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String path = GoRouterState.of(context).uri.path;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _NavPill(
          label: 'Home',
          selected: path == AppRoutePaths.home,
          onPressed: () => context.go(AppRoutePaths.home),
        ),
        _NavPill(
          label: 'Events',
          selected: path == AppRoutePaths.events,
          onPressed: () => context.go(AppRoutePaths.events),
        ),
        _NavPill(
          label: 'Community',
          selected: path == AppRoutePaths.links,
          onPressed: () => context.go(AppRoutePaths.links),
        ),
        _NavPill(
          label: 'About',
          selected: path == AppRoutePaths.about,
          onPressed: () => context.go(AppRoutePaths.about),
        ),
      ],
    );
  }
}

final class _NavPill extends StatelessWidget {
  const _NavPill({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: selected ? colors.primary : colors.onSurface,
          backgroundColor: selected
              ? colors.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    );
  }
}

/// Drawer used on narrow layouts (opened from [SiteHeaderBar] menu).
final class SiteNavDrawer extends StatelessWidget {
  const SiteNavDrawer({super.key, required this.joinLabel, required this.joinUrl});

  final String joinLabel;
  final String joinUrl;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
            const DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                'Navegação',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                context.go(AppRoutePaths.home);
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_outlined),
              title: const Text('Events'),
              onTap: () {
                Navigator.pop(context);
                context.go(AppRoutePaths.events);
              },
            ),
            ListTile(
              leading: const Icon(Icons.groups_outlined),
              title: const Text('Community'),
              onTap: () {
                Navigator.pop(context);
                context.go(AppRoutePaths.links);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                context.go(AppRoutePaths.about);
              },
            ),
            ListTile(
              leading: const Icon(Icons.play_circle_outline),
              title: const Text('Vídeos'),
              onTap: () {
                Navigator.pop(context);
                context.go(AppRoutePaths.videos);
              },
            ),
            const Divider(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GradientCtaButton(
                label: joinLabel,
                onPressed: () {
                  Navigator.pop(context);
                  openExternalLink(context: context, url: joinUrl);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
