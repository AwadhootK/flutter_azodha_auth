import 'package:azo_auth/ui/widgets/custom_snackbar.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';

enum LocalAuthState {
  complete,
  pending
} // To check if auth is in progress or not

class LocalAuthStateClass {
  static LocalAuthState state = LocalAuthState.complete;
}

class LocalAuth {
  LocalAuth()
      : auth = LocalAuthentication(),
        log = Logger("LocalAuth");
  LocalAuthentication auth;

  LocalAuthState? localAuthState;
  Logger log;

  Future<bool> hasBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      log.info(e.toString());
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      log.info('getbiometrics error: $e');
      return <BiometricType>[];
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    // if (localAuthState == LocalAuthState.complete) return true;
    try {
      // localAuthState = LocalAuthState.pending;
      var authentication = await auth.authenticate(
        localizedReason: 'Scan Fingerprint to Authenticate',
        options: const AuthenticationOptions(
          sensitiveTransaction: false,
          useErrorDialogs: true, //Inbuilt User Dialogs
          stickyAuth: true, //To continue auth after interuptions
        ),
      );
      // localAuthState = auth ? LocalAuthState.complete : LocalAuthState.pending;
      return authentication;
    } on PlatformException catch (e) {
      customSnackBar(content: e.toString());

      log.info('getbiometrics error: $e');
      return false;
    } catch (e) {
      return false;
    }
  }
}
