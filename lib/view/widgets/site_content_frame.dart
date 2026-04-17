import 'package:flutter/material.dart';

/// Centers content and caps width; use **inside** the scrollable so the
/// scrollbar spans the full viewport width.
final class SiteContentFrame extends StatelessWidget {
  const SiteContentFrame({super.key, required this.child});

  final Widget child;

  static const double maxContentWidth = 1120;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: child,
        ),
      ),
    );
  }
}
