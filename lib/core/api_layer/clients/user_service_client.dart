import 'package:azo_auth/core/api_service/user_service.dart';
import 'package:logging/logging.dart';


class UserServiceClient {
  final logger = Logger('DependencyTesting');

  final _userservice = UserService();
  UserServiceClient() {
    logger.info("Got a Userclient");
    // _dio.interceptors.add(DioInterceptor());
  }

  UserService get userservice => _userservice;
}
