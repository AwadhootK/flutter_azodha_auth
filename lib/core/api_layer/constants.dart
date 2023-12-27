class Config {
  final String auth0ClientId;
  final String auth0Domain;
  final String appConfigUrl;
  final String openCareUrl;
  final String chatUrl;
  final String notificationApiUrl;
  final String supportEmailTech;
  final String contentConsentBlog;
  final String contentConsentPage;
  final String contentTermsOfUse;
  final String appName;
  final String loggerUrl;
  final String orgId;
  final String appUpdateConfigXml;
  final String chatWssUrl;
  final String orgUrlCode;
  final String preSignedFetchEndpoint;
  final String NOTIFICATION_API_URL;

  Config({
    required this.auth0ClientId,
    required this.auth0Domain,
    required this.appConfigUrl,
    required this.openCareUrl,
    required this.chatUrl,
    required this.notificationApiUrl,
    required this.supportEmailTech,
    required this.contentConsentBlog,
    required this.contentConsentPage,
    required this.contentTermsOfUse,
    required this.appName,
    required this.loggerUrl,
    required this.orgId,
    required this.appUpdateConfigXml,
    required this.chatWssUrl,
    required this.orgUrlCode,
    required this.preSignedFetchEndpoint,
    required this.NOTIFICATION_API_URL,
  });
}
