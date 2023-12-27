import 'package:azo_auth/core/db/shared_preferences_manager.dart';
import 'package:logging/logging.dart';

class SharedPreferencesManagerClient {
  final logger = Logger('DependencyTesting');

  final _sharedPreferencesManager = SharedPreferencesManager();
  SharedPreferencesManagerClient() {
    logger.info("Got a SharedPreferencesManagerClient");
  }

  SharedPreferencesManager get sharedPreferencesManager =>
      _sharedPreferencesManager;
}
