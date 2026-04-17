import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetup_flutter_caxias/domain/entities/site_copy.dart';

import '../router/app_router.dart';
import '../utils/external_link.dart';

final class SiteFooterBar extends StatelessWidget {
  const SiteFooterBar({super.key, required this.copy});

  final SiteCopy copy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.35),
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool narrow = constraints.maxWidth < 720;
          if (narrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  copy.siteTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${copy.footerCopyrightLine} ${copy.footerBuiltLine}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: _footerLinks(context, copy),
                ),
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      copy.siteTitle,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${copy.footerCopyrightLine} ${copy.footerBuiltLine}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  alignment: WrapAlignment.end,
                  children: _footerLinks(context, copy),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _footerLinks(BuildContext context, SiteCopy copy) {
    return <Widget>[
      _FooterTextButton(
        label: copy.footerDocumentationLabel,
        onPressed: () => openExternalLink(
          context: context,
          url: copy.footerDocumentationUrl,
        ),
      ),
      _FooterTextButton(
        label: copy.footerGithubLabel,
        onPressed: () => openExternalLink(
          context: context,
          url: copy.footerGithubUrl,
        ),
      ),
      _FooterTextButton(
        label: copy.footerConductLabel,
        onPressed: () => openExternalLink(
          context: context,
          url: copy.flutterCodeOfConductUrl,
        ),
      ),
      _FooterTextButton(
        label: copy.footerPrivacyLabel,
        onPressed: () => openExternalLink(
          context: context,
          url: copy.footerPrivacyUrl,
        ),
      ),
      _FooterTextButton(
        label: 'Vídeos',
        onPressed: () => context.go(AppRoutePaths.videos),
      ),
    ];
  }
}

final class _FooterTextButton extends StatelessWidget {
  const _FooterTextButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          decoration: TextDecoration.underline,
          decorationThickness: 1,
        ),
      ),
    );
  }
}
