import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/community_content.dart';
import '../router/app_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const double _wideLayoutBreakpoint = 840;

  static const List<_NavItem> _navItems = <_NavItem>[
    _NavItem(
      path: AppRoutePaths.home,
      label: 'Início',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    _NavItem(
      path: AppRoutePaths.about,
      label: 'Sobre',
      icon: Icons.groups_2_outlined,
      selectedIcon: Icons.groups_2,
    ),
    _NavItem(
      path: AppRoutePaths.events,
      label: 'Eventos',
      icon: Icons.event_outlined,
      selectedIcon: Icons.event,
    ),
    _NavItem(
      path: AppRoutePaths.links,
      label: 'Links',
      icon: Icons.link_outlined,
      selectedIcon: Icons.link,
    ),
    _NavItem(
      path: AppRoutePaths.videos,
      label: 'Vídeos',
      icon: Icons.play_circle_outline,
      selectedIcon: Icons.play_circle,
    ),
  ];

  int _selectedIndexForPath(String path) {
    final String normalized = path.isEmpty || path == '/'
        ? AppRoutePaths.home
        : path;
    final int index = _navItems.indexWhere(
      (_NavItem item) => item.path == normalized,
    );
    return index < 0 ? 0 : index;
  }

  void _goToIndex(BuildContext context, int index) {
    if (index < 0 || index >= _navItems.length) {
      return;
    }
    context.go(_navItems[index].path);
  }

  @override
  Widget build(BuildContext context) {
    final String path = GoRouterState.of(context).uri.path;
    final int selectedIndex = _selectedIndexForPath(path);
    final double width = MediaQuery.sizeOf(context).width;
    final bool useWideLayout = width >= _wideLayoutBreakpoint;

    if (useWideLayout) {
      final bool isExtended = width >= 1100;
      return Scaffold(
        body: Row(
          children: <Widget>[
            NavigationRail(
              extended: isExtended,
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) =>
                  _goToIndex(context, index),
              // With extended: true, labelType must be none or null (labels are
              // shown beside icons by default). See navigation_rail.dart assert.
              labelType: isExtended
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.selected,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.flutter_dash,
                      size: 36,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      CommunityContent.siteTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              destinations: <NavigationRailDestination>[
                for (final _NavItem item in _navItems)
                  NavigationRailDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: Text(item.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _SiteBody(child: child),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _navItems[selectedIndex].label,
          key: ValueKey<String>(_navItems[selectedIndex].path),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.flutter_dash,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      CommunityContent.siteTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < _navItems.length; i++)
                ListTile(
                  leading: Icon(
                    selectedIndex == i
                        ? _navItems[i].selectedIcon
                        : _navItems[i].icon,
                  ),
                  title: Text(_navItems[i].label),
                  selected: selectedIndex == i,
                  onTap: () {
                    Navigator.of(context).pop();
                    _goToIndex(context, i);
                  },
                ),
            ],
          ),
        ),
      ),
      body: _SiteBody(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) => _goToIndex(context, index),
        destinations: <NavigationDestination>[
          for (final _NavItem item in _navItems)
            NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: item.label,
            ),
        ],
      ),
    );
  }
}

class _SiteBody extends StatelessWidget {
  const _SiteBody({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

final class _NavItem {
  const _NavItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String path;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
