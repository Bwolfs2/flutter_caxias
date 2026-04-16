/// A meetup or community event shown on the site (static data).
final class CommunityEvent {
  const CommunityEvent({
    required this.title,
    required this.date,
    required this.description,
    this.registrationUrl,
    this.locationLabel,
  });

  final String title;
  final DateTime date;
  final String description;
  final String? registrationUrl;
  final String? locationLabel;
}
