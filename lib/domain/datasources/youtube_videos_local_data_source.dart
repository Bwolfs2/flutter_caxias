import '../entities/youtube_video.dart';

abstract interface class YoutubeVideosLocalDataSource {
  Future<List<YoutubeVideo>> fetchVideos();
}
