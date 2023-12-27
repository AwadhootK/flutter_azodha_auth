import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/explore_service.dart';
import 'package:logging/logging.dart';

class ExploreServiceClient {
  final logger = Logger('DependencyTesting');
  late final Config config;

  late final _exploreService;
  ExploreServiceClient({required this.config}) {
    _exploreService = ExploreService(authConfig: config);
    logger.info("Got a ExploreServiceclient");
  }

  ExploreService get exploreService => _exploreService;
}
