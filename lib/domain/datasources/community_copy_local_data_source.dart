import '../entities/site_copy.dart';

abstract interface class CommunityCopyLocalDataSource {
  Future<SiteCopy> fetchSiteCopy();
}
