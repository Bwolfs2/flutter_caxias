/// A meetup or community event shown on the site.
final class CommunityEvent {
  const CommunityEvent({
    required this.title,
    required this.date,
    required this.description,
    this.registrationUrl,
    this.locationLabel,
    this.coverImageUrl,
  });

  final String title;
  final DateTime date;
  final String description;
  final String? registrationUrl;
  final String? locationLabel;

  /// Optional hero image for landing cards (HTTPS URL).
  final String? coverImageUrl;
}
