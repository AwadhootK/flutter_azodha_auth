import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/clients/dio_client.dart';
import 'package:azo_auth/core/api_layer/clients/user_service_client.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/auth0_api_service.dart';
import 'package:azo_auth/core/config.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:dio/dio.dart';


import '../models/patientprogram.dart';

class PatientAuthService {
  late final Config authConfig;
  PatientAuthService({required Config authConfig});
  Dio dio = AuthDependencyInjector.getIt.get<DioClient>().dio;
  String patientId = AuthDependencyInjector.getIt
          .get<UserServiceClient>()
          .userservice
          .fetchCurrentUser()
          .patientid ??
      '';
  Future<List<Programme>> getPatientprogram() async {
    Response response;
    Credentials cred = await Auth0AuthenticationService(authConfig: authConfig).getCred();
    dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
    dio.options.headers['content-Type'] = 'application/json';

    String url = '${authConfig.appConfigUrl}api/patients/$patientId/programs';
    //try {
    response = await dio.get(url);
    if (response.statusCode == 200) {
      List<Programme> programs = response.data;
      return programs;
    } else {
      return response.data;
    }
    // } catch (e) {
    //   log(e.toString());
    //   rethrow;
    // }
  }
}
