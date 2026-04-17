import '../entities/social_link.dart';

abstract interface class CommunitySocialLinksLocalDataSource {
  Future<List<SocialLink>> fetchSocialLinks();
}
