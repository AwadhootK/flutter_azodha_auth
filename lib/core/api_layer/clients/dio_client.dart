import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/interceptors/dio_interceptor.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';

class DioClient {
  final logger = Logger('DependencyTesting');
  late final Config config;

  final _dio = Dio();
  DioClient({required this.config}) {
    logger.info("Got a DioClient");
    _dio.interceptors.add(DioInterceptor(authConfig: config));
  }

  Dio get dio => _dio;
}
