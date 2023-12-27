import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/clients/sharedpreferences_client.dart';
import 'package:azo_auth/core/api_layer/clients/user_service_client.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/auth0_api_service.dart';
import 'package:azo_auth/core/api_service/care_team_api_service.dart';
import 'package:azo_auth/core/api_service/chat_bloc_handler.dart';
import 'package:azo_auth/core/api_service/local_auth_service.dart';
import 'package:azo_auth/core/api_service/notification_service.dart';
import 'package:azo_auth/core/api_service/save_blogs_service.dart';
import 'package:azo_auth/repos/auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AuthDependencyInjector {
  static final getIt = GetIt.instance;
  static late final Config authConfig;

  static void setAuthDependencies({required Config authConfig}) {
    log('Setting auth dependencies');
    AuthDependencyInjector.authConfig = authConfig;
    _getRepo();
    _getCareTeamService();
    _getAuth0AuthenticationService();
    _getSharedPreferencesManager();
    _getHabitRepositoryClient();
    _getDio();
    _getUserService();
    _getAuth0();
    _getSaveBlogsService();
    _getChatBlocHandler();
    _getLocalAuth();
    _getNotificationService();
    log('Done setting auth dependencies');
  }

  static void _getRepo() {
    getIt.registerLazySingleton<AuthRepo>(
        () => AuthRepo(authConfig: authConfig));
  }

  static void _getCareTeamService() {
    getIt.registerLazySingleton<CareTeamService>(
        () => CareTeamService(authConfig: authConfig));
  }

  static void _getAuth0AuthenticationService() {
    getIt.registerLazySingleton<Auth0AuthenticationService>(
        () => Auth0AuthenticationService(authConfig: authConfig));
  }

  static void _getSharedPreferencesManager() {
    getIt.registerLazySingleton<SharedPreferencesManagerClient>(
        () => SharedPreferencesManagerClient());
  }

  static void _getDio() {
    getIt.registerLazySingleton<Dio>(() => Dio());
  }

  static void _getUserService() {
    getIt.registerLazySingleton<UserServiceClient>(() => UserServiceClient());
  }

  static void _getAuth0() {
    getIt.registerLazySingleton<Auth0>(() => Auth0('', ''));
  }

  static void _getSaveBlogsService() {
    getIt.registerLazySingleton<SaveBlogsService>(() => SaveBlogsService());
  }

  static void _getChatBlocHandler() {
    getIt.registerLazySingleton<ChatBlocHandler>(
        () => ChatBlocHandler(authConfig: authConfig));
  }

  static void _getLocalAuth() {
    getIt.registerLazySingleton<LocalAuth>(() => LocalAuth());
  }

  static void _getNotificationService() {
    getIt.registerLazySingleton<NotificationService>(
        () => NotificationService(config: authConfig));
  }

  static void _getHabitRepositoryClient() {
    // getIt.registerLazySingleton<HabitRepository>(() => HabitRepository());
  }
}
