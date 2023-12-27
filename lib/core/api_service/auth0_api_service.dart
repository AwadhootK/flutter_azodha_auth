import 'dart:developer' as dev;
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/api_response.dart';
import 'package:azo_auth/core/api_layer/clients/sharedpreferences_client.dart';
import 'package:azo_auth/core/api_layer/clients/user_service_client.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/care_team_api_service.dart';
import 'package:azo_auth/core/api_service/save_blogs_service.dart';
import 'package:azo_auth/core/api_service/user_service.dart';
import 'package:azo_auth/core/config.dart';
import 'package:azo_auth/core/db/shared_preferences_manager.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:azo_auth/models/patientmodel.dart';
import 'package:azo_auth/patientauthorization/models/patientprogram.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class Auth0AuthenticationService {
  final Auth0 auth0;
  final SharedPreferencesManager sharedPreferencesManager;
  final UserService userservice;
  final CareTeamService careTeamService;
  final Logger log;
  final Dio dio;
  final Config authConfig;

  Credentials? credentials;
  final bool newuser = false;

  Auth0AuthenticationService({required this.authConfig})
      : auth0 = Auth0(authConfig.auth0Domain, authConfig.auth0ClientId),
        sharedPreferencesManager = AuthDependencyInjector.getIt
            .get<SharedPreferencesManagerClient>()
            .sharedPreferencesManager,
        userservice =
            AuthDependencyInjector.getIt.get<UserServiceClient>().userservice,
        careTeamService = AuthDependencyInjector.getIt.get<CareTeamService>(),
        log = Logger('Auth0AuthenticationService'),
        dio = Dio();

// Auth0AuthenticationService auth0AuthenticationService=AppDependencyInjector.getIt.get<Auth0AuthenticationServiceClient>().auth0AuthenticationService;
  Future currentUser() async {
    Credentials credentials = await auth0.credentialsManager.credentials();

    UserProfile userProfile =
        await auth0.api.userProfile(accessToken: credentials.accessToken);
    // logger.shout('Fetched User Profile for : ${userProfile.email}');
    return userProfile;
  }

  Future initUser() {
    // ignore: todo
    // TODO: implement initUser
    throw UnimplementedError();
  }

  Future<ApiResponse> signIn() async {
    try {
      credentials = await auth0.webAuthentication(scheme: 'app').login(scopes: {
        'profile',
        'email',
        'offline_access',
        'openid',
        'phone number'
      }, parameters: {
        'prompt': 'login',
        'screen_hint': 'app-login'
      });

      // isloading = true;
      // notifyListeners();
      UserProfile userProfile = await currentUser();
      userservice.addUser(userProfile.name, userProfile.email);

      Map<String, dynamic> value =
          await getPatient(userProfile.phoneNumber.toString());

      log.info('The tokens here - 4: ${value['id']}');
      userservice.updateCurrentUser(value['id'].toString(),
          value['firstName'].toString(), value['lastName'].toString());
      // log.info('User profile is : ${user.patientid}');
      // await FCMServices().storeToken(myToken, patiendId);

      sharedPreferencesManager.setUserLoginState(true);
      if (value.containsKey("New User")) {
        return const ApiResponse(data: "New User");
      }
      dev.log('done here');
      return ApiResponse(data: credentials);
      // ...
    } on WebAuthenticationException catch (e) {
      log.info('Error while sign in $e');
      return ApiResponse(error: e.toString(), data: e.details);
    } catch (e) {
      log.info('Error while sign in $e');
      return ApiResponse(error: e.toString());
    }
  }

  Future signOut() async {
    try {
      // await auth0.webAuthentication( ).logout();
      await auth0.credentialsManager.clearCredentials();
      await clearalltokens();
      //await Hive.deleteFromDisk();
      return null;
      // ...
    } on WebAuthenticationException catch (e) {
      log.warning('Logout Failed : $e');
      return e.message;
    } catch (_) {
      log.warning('Logout Failed : $_');
      return ('Logout Failed : $_');
    }
  }

  Future<dynamic> getPatient(String email) async {
    Credentials cred = await getCred();
    Map<String, dynamic> patientInfo;
    try {
      dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
      String url =
          '${authConfig.appConfigUrl}api/patients?phone=${email.replaceAll('+', '%2B')}';
      log.info(url);
      Response response = await dio.get(url);
      log.info('Patient fetched succesfully ${response.data}');
      patientInfo = response.data;
      return patientInfo;
    } on DioError catch (e) {
      if (e.response!.statusCode == 404 || e.response!.statusCode == 404) {
        Map<String, dynamic> patientInfo = {"New User": 404};
        log.info('Patient fetched unsuccesfully $e : Seems like new patient');
        return patientInfo;
      } else {
        log.info('Patient fetched unsuccesfully $e');
        return e.response?.data;
      }
    }
  }

  Future<dynamic> createPatientData(
      PatientModel patientModel, String gender, bool dependant) async {
    Credentials cred = await getCred();
    String? accessToken = cred.idToken;
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.headers['content-Type'] = 'application/json';
    Response<dynamic> response;
    try {
      response =
          await dio.post('${authConfig.appConfigUrl}api/patients', data: {
        "firstName": patientModel.firstName,
        "lastName": patientModel.lastName,
        "middleName": null,
        "gender": gender,
        "birthDate": patientModel.birthDate?.toIso8601String(),
        "addressLine1": patientModel.addressLine1,
        "addressLine2": patientModel.addressLine2,
        "city": null,
        "state": null,
        "country": null,
        "email": patientModel.email,
      });
      if (response.statusCode == 200) {
        if (response.data.toString().length < 5) {
          throw 'Somthinng went Wrong';
        } else {
          PatientModel res =
              PatientModel.fromJson(Map<String, dynamic>.from(response.data));
          log.info('Patient created succesfully ${response.data}');
          return res;
        }
      } else {
        return response.data.toString();
      }
    } catch (e) {
      log.info('During the Creation of Patient ${e.toString()}');
      return e;
    }
  }

  Future<Credentials> getCred() async {
    return await auth0.credentialsManager.credentials();
  }

  Future clearalltokens() async {
    await Future.wait<dynamic>([
      sharedPreferencesManager.deleteUserLoginState(),
      sharedPreferencesManager.deleteNavigatortokens(),
      // sharedPreferencesManager.setPin(''),
      userservice.box.clear(),
      // SettingsService.box.clear(),

      SaveBlogsService.box.clear(),
      // NotificationBoxService.clearbox(),
      // ChatLocalService.clear()
    ]);
  }

  Future<dynamic> getPatientWithCdt(String patientId) async {
    Credentials cred = await getCred();
    Map<String, dynamic> patientInfo;
    try {
      dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
      String url =
          '${authConfig.appConfigUrl}api/patients/$patientId?cdtName=cdt-patientconsent';
      log.info(url);
      Response response = await dio.get(url);
      log.info('Patient fetched succesfully ${response.data}');
      patientInfo = response.data;
      return patientInfo;
    } on DioError catch (e) {
      if (e.response!.statusCode == 404 || e.response!.statusCode == 404) {
        Map<String, dynamic> patientInfo = {"New User": 404};
        log.info('Patient fetched unsuccesfully $e : Seems like new patient');
        return patientInfo;
      } else {
        log.info('Patient fetched unsuccesfully $e');
        return e.response?.data;
      }
    }
  }

  Future<dynamic> updateConsentCdt(String patientId, String? recordID) async {
    Credentials cred = await getCred();
    Map<String, dynamic> patientInfo;
    try {
      dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
      String url = '${authConfig.appConfigUrl}api/patients/$patientId';
      log.info(url);

      var data = {
        "cdts": [
          {
            "name": "cdt-patientconsent",
            "multiRecord": true,
            "records": [
              {
                "fields": [
                  {"key": "cdtf-conset", "value": "Yes"}
                ]
              }
            ]
          },
        ]
      };

      if (recordID != null) {
        data = {
          "cdts": [
            {
              "name": "cdt-patientconsent",
              "multiRecord": true,
              "records": [
                {
                  "id": recordID,
                  "fields": [
                    {"key": "cdtf-conset", "value": "Yes"}
                  ]
                }
              ]
            },
          ]
        };
      }

      Response response = await dio.put(url, data: data);
      log.info('Patient Consent CDT Updated successfully: ${response.data}');
      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode == 404 || e.response!.statusCode == 404) {
        log.info('Patient Consent CDT Updated unsuccesfully $e');
        return false;
      } else {
        log.info('Patient Consent CDT Updated unsuccesfully $e');
        return false;
      }
    }
  }

  Future<Programme?> getPatientprogram(String programname) async {
    Response response;
    Credentials cred = await getCred();
    dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
    dio.options.headers['content-Type'] = 'application/json';
    String patientId = userservice.fetchCurrentUser().patientid ?? '';
    String url =
        '${authConfig.appConfigUrl}api/patients/$patientId/programs/$programname';
    try {
      log.info(url);
      response = await dio.get(url);
      if (response.statusCode == 200) {
        Programme program = Programme.fromJson(response.data);
        return program;
      } else {
        return response.data;
      }
    } catch (e) {
      log.info(e.toString());
      rethrow;
    }
  }
}
