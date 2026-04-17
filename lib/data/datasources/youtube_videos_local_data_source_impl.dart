import 'package:meetup_flutter_caxias/domain/datasources/youtube_videos_local_data_source.dart';
import 'package:meetup_flutter_caxias/domain/entities/youtube_video.dart';

final class YoutubeVideosLocalDataSourceImpl
    implements YoutubeVideosLocalDataSource {
  static final List<YoutubeVideo> _videos = <YoutubeVideo>[
    const YoutubeVideo(
      videoId: 'yAaMaBZ_wDY',
      title: 'Placeholder — substitua pelo título do seu vídeo',
    ),
    const YoutubeVideo(
      videoId: 'd_qvLDhkgN8',
      title: 'Outro placeholder — edite em youtube_videos_local_data_source_impl.dart',
    ),
  ];

  @override
  Future<List<YoutubeVideo>> fetchVideos() async =>
      List<YoutubeVideo>.unmodifiable(_videos);
}
