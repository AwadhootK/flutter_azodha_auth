enum Flavour { development, production }

extension StringX on String {
  Flavour get flavourByString {
    return Flavour.values.firstWhere((flavour) => flavour.toString() == this);
  }
}

abstract class EnvironmentBase {
  final Flavour flavour;
  final String serverURL;
  final String patientId;

  EnvironmentBase(this.flavour, this.serverURL, this.patientId);

  String get flavourName => flavour.toString();
}

abstract class AuthEnvironment extends EnvironmentBase with ApiMixin {
  AuthEnvironment(Flavour flavour, String serverURL, String patientId)
      : super(flavour, serverURL, patientId);

  static AuthEnvironment? _instance;

  static AuthEnvironment get instance =>
      _instance ??
      (throw Exception(
          "You need to call `Environment.initialize` before accessing the getter function"));

  factory AuthEnvironment.initialize(
      {Flavour? flavour, String? serverURL, String? patientId}) {
    flavour ??=
        const String.fromEnvironment("flavor", defaultValue: "production")
            .flavourByString;

    return _instance ??= _getInstanceByFlavour(flavour, serverURL, patientId);
  }

  static AuthEnvironment _getInstanceByFlavour(
      Flavour flavour, String? serverURL, String? patientId) {
    switch (flavour) {
      case Flavour.development:
        return _Dev(flavour, serverURL ?? "", patientId ?? "");
      case Flavour.production:
        return _Prod(flavour, serverURL ?? "", patientId ?? "");
    }
  }
}

class _Dev extends AuthEnvironment {
  _Dev(Flavour flavour, String serverURL, String patientId)
      : super(flavour, serverURL, patientId);

  @override
  String get baseUrl => serverURL; // Use the provided server URL

  //! get other endpoints
}

class _Prod extends AuthEnvironment {
  _Prod(Flavour flavour, String serverURL, String patientId)
      : super(flavour, serverURL, patientId);

  @override
  String get baseUrl => serverURL; // Use the provided server URL

  //! get other endpoints
}

mixin ApiMixin {
  String get baseUrl;

  //! get other endpoints
}
