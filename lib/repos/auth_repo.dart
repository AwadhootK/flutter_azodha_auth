import 'dart:developer' as dev;
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/clients/user_service_client.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/auth0_api_service.dart';
import 'package:azo_auth/core/api_service/fcm_service.dart';
import 'package:azo_auth/core/api_service/user_service.dart';
import 'package:azo_auth/core/db/shared_preferences_manager.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:azo_auth/patientauthorization/models/patientprogram.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';

class AuthRepo {
  final log = Logger('Authentication');
  final Config authConfig;

  AuthRepo({required this.authConfig});

  UserService userservice =
      AuthDependencyInjector.getIt.get<UserServiceClient>().userservice;

  setUpNotifications(Map<String, dynamic> value) async {
    late final FirebaseMessaging _messaging;
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    String? token = await _messaging.getToken();
    await FCMService(authConfig: authConfig)
        .addToken(token ?? '', value['id'].toString());
    await FCMService(authConfig: authConfig)
        .getNotifications(value['id'].toString());
  }

  Future<bool> refreshCredentials(Credentials credentials) async {
    final Auth0 auth0 = Auth0(authConfig.auth0Domain, authConfig.auth0ClientId);
    try {
      credentials = await auth0.api.renewCredentials(
          refreshToken: credentials.refreshToken!,
          scopes: {
            'profile',
            'email',
            'offline_access',
            'openid',
            'phone number'
          });
      bool hasvalidrenewedcreds =
          await auth0.credentialsManager.hasValidCredentials();
      await auth0.credentialsManager.storeCredentials(credentials);
      log.info('Refershing Credentials : $hasvalidrenewedcreds');
      return hasvalidrenewedcreds;
    } catch (e) {
      return false;
    }
  }

  checkAuthentication() async {}

  loginByAuth0() async {}

  Future<bool> logout() async {
    try {
      final Auth0 auth0 =
          Auth0(authConfig.auth0Domain, authConfig.auth0ClientId);
      final Auth0AuthenticationService auth0authentication =
          Auth0AuthenticationService(authConfig: authConfig);
      SharedPreferencesManager sharedPreferencesManager =
          SharedPreferencesManager();
      await auth0.credentialsManager.clearCredentials();
      await auth0authentication.clearalltokens();
      await sharedPreferencesManager.deleteUserLoginState();
      await sharedPreferencesManager.deleteNavigatortokens();
      await userservice.deleteAllUsers();
      return true;
    } catch (e) {
      log.shout('Logout Unsuccessfull');
      log.info(e.toString());
      dev.log(e.toString());
      return false;
    }
  }

  // Future<bool> createAccount(
  //     PatientModel patientModel, String gender, bool dependant) async {
  //   try {
  //     Userservice userservice =
  //         AppDependencyInjector.getIt.get<UserServiceClient>().userservice;
  //     final Auth0AuthenticationService auth0authentication =
  //         Auth0AuthenticationService();
  //     PatientModel response = await auth0authentication.createPatientData(
  //         patientModel, gender, dependant);
  //     await userservice.addUser(response.firstName, response.email);
  //     userservice.updateCurrentUser(
  //         response.id, response.firstName ?? "", response.lastName ?? "");
  //     SharedPreferencesManager().setUserLoginState(false);
  //     return true;
  //   } catch (e) {
  //     log(e.toString());
  //     return false;
  //   }
  // }

  Future<Programme?> getPatientProgram() async {
    final Auth0AuthenticationService auth0authentication =
        Auth0AuthenticationService(authConfig: authConfig);
    try {
      String ripple3highs = "prog-ripple-diabetes-management-programme";
      String preenroll = "prog-ripple-pre-enrolment";
      Programme? programs;
      programs = await auth0authentication.getPatientprogram(ripple3highs);
      if (programs?.name == ripple3highs) {
        log.shout('Patient is part of $ripple3highs');
        return programs;
      } else {
        programs ??= await auth0authentication.getPatientprogram(preenroll);

        if (programs?.name == preenroll) {
          log.shout('Patient is part of $preenroll');
          return programs;
        } else {
          return null;
        }
      }
    } catch (e) {
      log.info('Patient Check did not work wel ');
      return null;
    }
  }
}
