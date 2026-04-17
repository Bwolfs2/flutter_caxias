/// Icon keys for [SocialLink] — mapped to [IconData] in the view layer only.
enum SocialLinkIconKind {
  calendar,
  chat,
  play,
  code,
  work,
}

/// External profile or community link (no Flutter types).
final class SocialLink {
  const SocialLink({
    required this.label,
    required this.url,
    required this.iconKind,
  });

  final String label;
  final String url;
  final SocialLinkIconKind iconKind;
}
