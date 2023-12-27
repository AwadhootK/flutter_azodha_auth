import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter_cache_manager/flutter_cache_manager.dart' as cache;

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/clients/sharedpreferences_client.dart';
import 'package:azo_auth/core/api_layer/clients/user_service_client.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/auth0_api_service.dart';
import 'package:azo_auth/core/api_service/care_team_api_service.dart';
import 'package:azo_auth/core/api_service/chat_bloc_handler.dart';
import 'package:azo_auth/core/api_service/local_auth_service.dart';
import 'package:azo_auth/core/api_service/notification_box_service.dart';
import 'package:azo_auth/core/api_service/save_blogs_service.dart';
import 'package:azo_auth/core/api_service/user_service.dart';
import 'package:azo_auth/core/config/environment/environment.dart';
import 'package:azo_auth/core/db/shared_preferences_manager.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:azo_auth/design/auth_design_config.dart';
import 'package:azo_auth/models/consent.dart';
import 'package:azo_auth/models/patientModelWithCdt.dart';
import 'package:azo_auth/models/patientmodel.dart';
import 'package:azo_auth/repos/auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:bloc/bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String serverBaseUrl = "https://welkinsandbox.platform.azo.dev";
  AuthDesignConfig? authDesignConfig;

  late final AuthRepo authRepo;
  late final CareTeamService careTeamService;
  late final Auth0AuthenticationService auth0AuthenticationService;
  late final SharedPreferencesManager sharedPreferencesManager;
  late Dio dio;
  late UserService userservice;
  late Auth0 auth0;
  late SaveBlogsService saveblogsservice;
  late ChatBlocHandler chatBlocHandler;
  late LocalAuth localAuth;
  final log = Logger('Authentication');
  Credentials? credentials;
  String patientId = '';
  PatientModel? cachedPatientModel;
  PatientModelWithCdt? cachedPatientModelWithCdt;

  late Config authConfig;

// initialize all the dependencies in constructor
  AuthBloc() : super(AuthInitialState()) {
    on<AuthInitialEvent>(authInitialEventHandler);
    on<AuthLoginEvent>(authLoginEventHandler);
    on<AuthLogoutEvent>(authLogoutEventHandler);
  }

  FutureOr<void> authInitialEventHandler(
    AuthInitialEvent event,
    Emitter<AuthState> emit,
  ) async {
    await Hive.initFlutter('documents');
    await AuthDependencyInjector.getIt
        .get<UserServiceClient>()
        .userservice
        .init();
    await NotificationBoxService.init();

    await AuthDependencyInjector.getIt
        .get<SharedPreferencesManagerClient>()
        .sharedPreferencesManager
        .init();
    // await AuthDependencyInjector.getIt
    //     .get<NotificationService>()
    //     .initializeFlutterLocalNotificationsPlugin();

    await SaveBlogsService.init();
    // await Firebase.initializeApp();
    NotificationBoxService.clearbox();
    // device orientation
    // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // serverBaseUrl = event.serverBaseUrl ?? serverBaseUrl;
    authDesignConfig = event.designConfig;
    authConfig = event.authConfig!;
    authRepo = AuthRepo(authConfig: authConfig);
    // careTeamService = CareTeamService(authConfig: authConfig);
    // auth0AuthenticationService =
    //     Auth0AuthenticationService(authConfig: authConfig);
    // sharedPreferencesManager = SharedPreferencesManager();
    // dio = Dio();
    // userservice = AuthDependencyInjector.getIt.get<UserService>();
    // auth0 = Auth0(authConfig.auth0Domain, authConfig.auth0ClientId);
    // saveblogsservice = SaveBlogsService();
    // chatBlocHandler = ChatBlocHandler(authConfig: authConfig);
    // localAuth = LocalAuth();

    AuthEnvironment.initialize(
      flavour: Flavour.development,
      serverURL: serverBaseUrl,
    );

    emit(AuthShowLandingState());
  }

  FutureOr<void> authLoginEventHandler(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    final Auth0AuthenticationService auth0AuthenticationService =
        Auth0AuthenticationService(authConfig: authConfig);
    try {
      emit(AuthLoadingState());
      UserService userservice =
          AuthDependencyInjector.getIt.get<UserServiceClient>().userservice;
      CareTeamService careTeamService =
          AuthDependencyInjector.getIt.get<CareTeamService>();
      var authstatus = (await auth0AuthenticationService.signIn()).getData;
      dev.log("AuthStatus: $authstatus");
      if (authstatus == "New User") {
        dev.log("New User");
        emit(AuthNotAuthorisedState());
      } else {
        if (authstatus.runtimeType != Credentials) {
          dev.log("runtime type is not credentials");
          await auth0AuthenticationService.clearalltokens();
          dev.log("cleared all tokens");
          add(AuthLogoutEvent());
        } else {
          dev.log("runtime type is credentials");
          credentials = authstatus;
          UserProfile userProfile =
              await auth0AuthenticationService.currentUser();
          userservice.addUser(userProfile.name, userProfile.email);
          Map<String, dynamic> value = await auth0AuthenticationService
              .getPatient(userProfile.phoneNumber.toString());
          Map<String, dynamic>? valueWithCdt =
              await auth0AuthenticationService.getPatientWithCdt(value['id']);

          cachedPatientModelWithCdt =
              PatientModelWithCdt.fromJson(valueWithCdt!);

          PatientModel patientModel = PatientModel.fromJson(value);
          userservice.updatePatientModel(patientModel);
          userservice.updateCurrentUser(value['id'].toString(),
              value['firstName'].toString(), value['lastName'].toString());
          chatBlocHandler.connectChat();
          await careTeamService.getCareTeam(value['id']);
          saveblogsservice.setSavedBlog();
          patientId = patientModel.id;
          await authRepo.setUpNotifications(value);
          log.shout('AppLogin; $value');
          if (value.containsKey("New User")) {
            emit(AuthNotAuthorisedState());
          } else {
            emit(AuthSignedInState());
          }
        }
      }
    } catch (e) {
      log.shout('User has invaild credentials');
      await auth0AuthenticationService.clearalltokens();
      add(AuthLogoutEvent());
    }
  }

  FutureOr<void> authCheckAuthenticationEvent(
      AuthCheckAuthenticationEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final isLoggedIn = await auth0.credentialsManager.hasValidCredentials();
    try {
      if (isLoggedIn) {
        log.shout('User has valid credentials========>>>>>>>>');
        // Fetching credentials and refreshing if expired
        credentials = await auth0.credentialsManager.credentials();

        UserProfile userProfile =
            await auth0AuthenticationService.currentUser();
        userservice.addUser(userProfile.name, userProfile.email);
        Map<String, dynamic>? value = await auth0AuthenticationService
            .getPatient(userProfile.phoneNumber.toString());
        Map<String, dynamic>? valueWithCdt =
            await auth0AuthenticationService.getPatientWithCdt(value!['id']);

        if (value.containsKey("New User")) {
          await sharedPreferencesManager.deleteConsentToken();
          await sharedPreferencesManager.deleteLocalAuthToken();

          emit(AuthNotAuthorisedState());
        } else {
          PatientModel patientModel;

          patientModel = PatientModel.fromJson(value);

          log.shout("Patient Model");
          debugPrint(valueWithCdt.toString(), wrapWidth: 10000000000000);

          cachedPatientModelWithCdt =
              PatientModelWithCdt.fromJson(valueWithCdt!);
          userservice.updatePatientModel(patientModel);
          userservice.updateCurrentUser(value['id'].toString(),
              value['firstName'].toString(), value['lastName'].toString());
          chatBlocHandler.connectChat();

          await careTeamService.getCareTeam(value['id']);

          saveblogsservice.setSavedBlog();
          authRepo.setUpNotifications(value);
          patientId = patientModel.id;
          log.info('PATIENT ID - $patientId');
          emit(AuthSignedInState());
        }
      } else {
        log.shout('User has invaild credentials');
        await auth0AuthenticationService.clearalltokens();
        add(AuthLogoutEvent());
      }
    } catch (e) {
      log.shout('User has invaild credentials');
      await auth0AuthenticationService.clearalltokens();
      add(AuthLogoutEvent());
    }
  }

  FutureOr<void> authLogoutEventHandler(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    dev.log("success: here");
    bool success = await authRepo.logout();
    dev.log("success: $success");
    if (success) {
      cache.DefaultCacheManager().emptyCache();
      // final cookieManager = WebviewCookieManager();
      // await cookieManager.clearCookies();
      // await LmsRepo.logoutLitmos();
      emit(AuthLogoutState());
    }
  }
}
