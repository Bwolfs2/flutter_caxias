import 'package:flutter/material.dart';

import 'package:meetup_flutter_caxias/domain/entities/youtube_video.dart';

import '../app_data_scope.dart';
import '../utils/external_link.dart';
import '../widgets/site_content_frame.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  int _columnCountForWidth(double width) {
    if (width >= 1000) {
      return 3;
    }
    if (width >= 640) {
      return 2;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final AppDataScope scope = AppDataScope.of(context);
    return FutureBuilder(
      future: scope.youtubeVideos.fetchVideos(),
      builder: (BuildContext context, AsyncSnapshot<List<YoutubeVideo>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              'Não foi possível carregar os vídeos.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        final List<YoutubeVideo> videos = snapshot.data!;
        final ThemeData theme = Theme.of(context);
        if (videos.isEmpty) {
          return Center(
            child: Text(
              'Nenhum vídeo cadastrado. Edite '
              'lib/data/datasources/youtube_videos_local_data_source_impl.dart.',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          );
        }
        return CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SiteContentFrame(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        'Vídeos no YouTube',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Miniaturas oficiais do YouTube. Toque em um card para abrir o vídeo.',
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SiteContentFrame(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final int columns =
                        _columnCountForWidth(constraints.maxWidth);
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: columns == 1 ? 1.35 : 0.95,
                      ),
                      itemCount: videos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _YoutubeVideoCard(video: videos[index]);
                      },
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        );
      },
    );
  }
}

class _YoutubeVideoCard extends StatelessWidget {
  const _YoutubeVideoCard({required this.video});

  final YoutubeVideo video;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Semantics(
      button: true,
      label: '${video.title}. Abrir no YouTube',
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => openExternalLink(context: context, url: video.watchUrl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  video.thumbnailUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? progress,
                  ) {
                    if (progress == null) {
                      return child;
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder:
                      (BuildContext context, Object error, StackTrace? stackTrace) {
                    return ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 48,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.open_in_new,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Abrir no YouTube',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
