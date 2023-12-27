import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/auth0_api_service.dart';
import 'package:azo_auth/core/api_service/notification_box_service.dart';
import 'package:azo_auth/core/config.dart';
import 'package:azo_auth/models/notification_response_model.dart';
import 'package:azo_auth/models/notificationboxmodel.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class FCMService {
  FCMService({required this.authConfig});
  late Config authConfig;
  final log = Logger('FCM Service');

  Future addToken(String fcmToken, String id) async {
    final Dio dio = Dio();
    Credentials cred =
        await Auth0AuthenticationService(authConfig: authConfig).getCred();
    dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
    log.info("${authConfig.NOTIFICATION_API_URL}api/notifications/patients/$id");
    try {
      Response res = await dio.post(
          '${authConfig.NOTIFICATION_API_URL}api/notifications/patients/$id',
          data: {
            "token": fcmToken,
          });

      log.info(res.data.toString());
    } catch (e) {
      log.info(e.toString());
      return;
    }
    log.info("Added token to database");
    return;
  }

  Future getNotifications(String id) async {
    final Dio dio = Dio();
    List<NotificationBoxModel> pushnotifs = [];
    Credentials cred = await Auth0AuthenticationService(authConfig: authConfig).getCred();
    dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
    log.info("${authConfig.NOTIFICATION_API_URL}api/history/$id");
    try {
      Response res =
          await dio.get('${authConfig.NOTIFICATION_API_URL}api/history/$id');

      for (var i in res.data) {
        NotificationResponseModel notificationResponseModel =
            NotificationResponseModel.fromJson(i);
        NotificationBoxModel notif = NotificationBoxModel()
          ..time = notificationResponseModel.createdAt ?? DateTime.now()
          ..message = notificationResponseModel.messageBody ?? '';
        pushnotifs.add(notif);
      }

      NotificationBoxService.savePushNotif(pushnotifs);
    } catch (e) {
      log.info(e.toString());
      NotificationBoxService.savePushNotif(pushnotifs);
    }
    log.info("Added token to database");
  }
}

// FCMService().AddToken("fcmToken", "id");
