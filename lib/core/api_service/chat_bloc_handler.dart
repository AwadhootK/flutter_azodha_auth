import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/clients/user_service_client.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/auth0_api_service.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:azo_chat/azo_chat.dart';
import 'package:logging/logging.dart';

class ChatBlocHandler {
  ChatBlocHandler({required this.authConfig});
  late Config authConfig;
  void connectChat() async {
    final ChatBloc chatBloc = AuthDependencyInjector.getIt.get();
    Credentials cred = await Auth0AuthenticationService(authConfig: authConfig).getCred();
    String patientId = AuthDependencyInjector.getIt
            .get<UserServiceClient>()
            .userservice
            .fetchCurrentUser()
            .patientid ??
        '';

    if (patientId.isNotEmpty && cred.idToken.isNotEmpty) {
      final Logger logger = Logger('chat-logger');

      //! TODO: Uncomment this when chat is ready
      // ChatConstants.currUserId = patientId;
      // chatBloc.add(ChatInitialFetchEvent(
      //   preSignedUrlFetchEndpoint: ChatConstants.preSignedFetchEndpoint,
      //   emptyChatText:
      //       "This is the start of your chat with your Ripple Care Team",
      //   logger: logger,
      //   bearerToken: cred.idToken,
      //   organisationCode: ChatConstants.organisationId,
      //   socketUrl: Config.CHAT_WSS_URL,
      //   currUserDpUrl: ChatConstants.currUserDpUrl,
      //   currUserName: ChatConstants.currUserName,
      //   otherUserDpUrl: ChatConstants.otherUserDpUrl,
      //   otherUserId: ChatConstants.otherUserId,
      //   otherUserName: ChatConstants.otherUserName,
      //   currUserId: patientId,
      //   roomId: '',
      // ));
    }
  }
}
