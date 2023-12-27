import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/clients/dio_client.dart';
import 'package:azo_auth/core/api_layer/clients/user_service_client.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/auth0_api_service.dart';
import 'package:azo_auth/core/config.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:azo_auth/models/user/careTeamMemberModel.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class CareTeamService {
  CareTeamService({required Config authConfig});

  late Config authConfig;
  final log = Logger('CareTeamService');
  CareTeamMemberModel? care;
  Future<List<Participant>>? getCareTeam(String patientId) async {
    Dio dio = AuthDependencyInjector.getIt.get<DioClient>().dio;
    Response response;
    String patientId = AuthDependencyInjector.getIt
            .get<UserServiceClient>()
            .userservice
            .fetchCurrentUser()
            .patientid ??
        '';
    Credentials cred =
        await Auth0AuthenticationService(authConfig: authConfig).getCred();
    dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';

    try {
      response = await dio
          .get('${authConfig.appConfigUrl}api/patients/$patientId/care-team');

      care = CareTeamMemberModel.fromJson(response.data);
      for (var element in care?.participants ?? []) {
        log.info("Care Team member : ${element.firstName}");
      }
    } catch (e) {
      log.info(e.toString());
      return [];
    }

    return care?.participants ?? [];
  }
}
