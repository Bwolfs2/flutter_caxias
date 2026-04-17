import 'package:flutter/material.dart';
import 'package:meetup_flutter_caxias/domain/entities/site_copy.dart';

import '../app_data_scope.dart';
import 'site_footer_bar.dart';
import 'site_header_bar.dart';

final class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AppDataScope scope = AppDataScope.of(context);
    return FutureBuilder<SiteCopy>(
      future: scope.communityCopy.fetchSiteCopy(),
      builder: (BuildContext context, AsyncSnapshot<SiteCopy> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Text(
                'Não foi possível carregar o conteúdo.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        }
        final SiteCopy copy = snapshot.data!;
        return Scaffold(
          endDrawer: SiteNavDrawer(
            joinLabel: copy.joinCommunityCtaLabel,
            joinUrl: copy.meetupUrl,
          ),
          body: Column(
            children: <Widget>[
              SiteHeaderBar(
                siteTitle: copy.siteTitle,
                joinUrl: copy.meetupUrl,
                joinLabel: copy.joinCommunityCtaLabel,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: child,
                    ),
                  ),
                ),
              ),
              SiteFooterBar(copy: copy),
            ],
          ),
        );
      },
    );
  }
}
