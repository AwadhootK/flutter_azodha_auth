import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/design/auth_design_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String bottomDecoratorImage = 'assets/bottom_decorator.png';
  static const String topDecoratorImage = 'assets/top_decorator.png';
  static const String faceIDImage = 'assets/faceid.png';
  static const String touchIDImage = 'assets/touchid.png';
  static const String faceAndTouchImage = 'assets/face&touch.png';
  static const String landingPhoneImage = 'assets/landingphone.png';
  static const String rippleLogoImage = 'assets/ripplelogo.png';
  static const String squareStarImage = 'assets/squarestar.png';
  static const String starImage = 'assets/star.png';
  static late Config config;

  static void initConfig() {
    config = Config(
      appConfigUrl: dotenv.get('APP_CONFIG_URL'),
      notificationApiUrl: dotenv.get('NOTIFICATION_API_URL'),
      auth0ClientId: dotenv.get('AUTH_CLIENT_ID'),
      auth0Domain: dotenv.get('AUTH_DOMAIN'),
      openCareUrl: dotenv.get('OPEN_CARE_URL'),
      chatUrl: dotenv.get('CHAT_URL'),
      supportEmailTech: dotenv.get('SUPPORT_EMAIL_TECH'),
      contentConsentBlog: dotenv.get('CONTENT0_CONSENT_BLOG'),
      contentConsentPage: dotenv.get('CONTENT0_CONSENT_PAGE'),
      contentTermsOfUse: dotenv.get('CONTENT0_TERMSOFUSE'),
      appName: dotenv.get('APPNAME'),
      loggerUrl: dotenv.get('LOGGERURL'),
      orgId: dotenv.get('ORG_ID'),
      appUpdateConfigXml: dotenv.get('APP_UPDATE_CONFIG_XML'),
      chatWssUrl: '',
      orgUrlCode: '',
      preSignedFetchEndpoint: '',
      NOTIFICATION_API_URL: '',
    );
  }

  static AuthDesignConfig authDesignConfig = AuthDesignConfig(
      topDecoratorImage: topDecoratorImage,
      bottomDecoratorImage: bottomDecoratorImage,
      faceIDImage: faceIDImage,
      touchIDImage: touchIDImage,
      faceAndTouchImage: faceAndTouchImage,
      landingPhoneImage: landingPhoneImage,
      rippleLogoImage: rippleLogoImage,
      squareStarImage: squareStarImage,
      starImage: starImage);
}
