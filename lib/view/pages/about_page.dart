import 'package:flutter/material.dart';

import 'package:meetup_flutter_caxias/domain/entities/site_copy.dart';

import '../app_data_scope.dart';
import '../utils/external_link.dart';

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
        final ThemeData theme = Theme.of(context);
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: <Widget>[
            Text(
              copy.aboutIntroTitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              copy.aboutIntroBody,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 28),
            Text(
              copy.aboutParticipateTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              copy.aboutParticipateBody,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 28),
            Text(
              copy.aboutConductTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              copy.aboutConductBody,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: () => openExternalLink(
                context: context,
                url: copy.flutterCodeOfConductUrl,
              ),
              icon: const Icon(Icons.gavel_outlined),
              label: const Text('Código de conduta Flutter'),
            ),
          ],
        );
      },
    );
  }
}
