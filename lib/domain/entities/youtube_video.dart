/// YouTube video entry backed by a static video id.
final class YoutubeVideo {
  const YoutubeVideo({
    required this.videoId,
    required this.title,
  });

  final String videoId;
  final String title;

  String get watchUrl => 'https://www.youtube.com/watch?v=$videoId';

  String get thumbnailUrl => 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
}
