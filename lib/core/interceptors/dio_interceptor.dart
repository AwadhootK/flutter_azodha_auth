import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/auth0_api_service.dart';
import 'package:azo_auth/core/config.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';


class DioInterceptor extends Interceptor {
  late final Config authConfig;

  DioInterceptor({required this.authConfig});

  
  // final _prefsLocator = getIt.get<AuthHelper>();
  final logger = Logger('Interceptors');
  String? path;
  DateTime? requestTime;
  DateTime? responseTime;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Credentials cred = await Auth0AuthenticationService(authConfig: authConfig).getCred();
    logger.info('ID Token: ${cred.idToken}');

    requestTime = DateTime.now();
    // add headers for source backend
    if (options.path.contains(authConfig.appConfigUrl)) {
      options.headers['Authorization'] = 'Bearer ${cred.idToken}';
      options.headers['accept'] = 'application/json';
      options.headers['Content-Type'] = 'application/json';
    }

    path = options.path;
    logger.info("Request Path: ${options.path}: ${handler.hashCode}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    responseTime = DateTime.now();
    logger.info(
        "Response Status: ${response.statusCode}: $path  Response Time: ${responseTime!.difference(requestTime!)}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.warning("DIO Error: ${err.message}: $path");
    super.onError(err, handler);
  }
}
