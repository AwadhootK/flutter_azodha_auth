import 'dart:convert';
import 'dart:developer';

import 'package:azo_auth/bloc/auth_bloc.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

class Log {
  static late final Config config;
  static late final IOWebSocketChannel _channelApp;
  static late final IOWebSocketChannel _channelEvent;

  static PackageInfo? packageInfo;

  static Future<void> connect() async {
    String url = config.loggerUrl;
    String urlAPP = '$url/app-logs';
    String urlEvents = '$url/event-logs';
    log('Connecting to $urlAPP and $urlEvents');

    // TODO : To be Configureable across different tenants

    _channelApp = IOWebSocketChannel.connect(Uri.parse(urlAPP), headers: {
      'Sec-WebSocket-Protocol': 'echo-protocol',
      'client-id': '7a7e423a-2e72-49e1-bcc6-3acd7d3230f9'
    });
    _channelEvent = IOWebSocketChannel.connect(Uri.parse(urlEvents), headers: {
      'Sec-WebSocket-Protocol': 'echo-protocol',
      'client-id': '7a7e423a-2e72-49e1-bcc6-3acd7d3230f9'
    });
    packageInfo = await PackageInfo.fromPlatform();
  }

  static Future<void> init(Config config) async {
    Log.config = config;
    await connect();
    Logger.root.level = Level.ALL;
    final uuid = const Uuid().v4();
    final AuthBloc authBloc = AuthDependencyInjector.getIt.get();
    Logger.root.onRecord.listen((record) {
      //Add code to relay back information to crash log provider service
      String patientId = '';
      try {
        patientId = AuthDependencyInjector.getIt.get<AuthBloc>().patientId;
      } catch (e) {
        patientId = '';
      }

      String userId = authBloc.credentials?.user.sub ??
          ''; //Auth0Authentication.credentials?.user.sub ?? '';
      String subtype = record.message.split(';').first;

      final message = {
        "organizationId": int.parse(config.orgId),
        "sourceApp":
            "${packageInfo?.packageName}-${packageInfo?.version}-(${packageInfo?.buildNumber})",
        "eventType": record.loggerName,
        "eventSubType": subtype,
        "eventData":
            '${record.message} ${record.error ?? ''} ${record.stackTrace ?? ''} ',
        "externalUserId": patientId,
        "sessionId": uuid,
        "authenticationId": userId,
        "createdAt": record.time.toIso8601String()
      };
      if (!kDebugMode) {
        if (record.level == Level.SHOUT) {
          log('Sinking Data to Event Log');
          _channelEvent.sink.add(json.encode(message));
        }
        if (record.level != Level.FINE) {
          log('Sinking Data to App Log');
          _channelApp.sink.add(json.encode(message));
        }
      }

      debugPrint(
        '${record.loggerName} :${record.level.name}: ${record.time}: ${record.message}',
      );
    });
    return;
  }
}
