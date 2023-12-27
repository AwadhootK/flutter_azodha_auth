import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _sharedPrefs;
  final log = Logger('Shared Preferences');

  //Using an init function to avail instant retival facility by enabling a global
  // /static object of shared preferences
  Future init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    // ...
    if (_sharedPrefs.getBool('first_run') ?? true) {
      await _sharedPrefs.setBool('first_run', false);
      await SharedPreferencesManager().deleteUserLoginState();
      log.info('Removing the user login state as this is the first run');
      //await SharedPreferencesManager().deleteUser();
    }
  }

//Tab State handels the tab screen the user is on
//and makes sure it persists
  Future<void> saveTabState(int tabNo) async {
    await _sharedPrefs.setInt('tabstate', tabNo);
  }

  int? getTabState() {
    return _sharedPrefs.getInt('tabstate');
  }

  Future<void> deleteTabState() async {
    await _sharedPrefs.remove("tabstate");
  }

  // User login State tells us if the user is logging in for the first time or not
  Future<void> setUserLoginState(bool accessLogin) async {
    await _sharedPrefs.setBool('UserloginState', accessLogin);
  }

  bool? getUserLoginState() {
    return _sharedPrefs.getBool('UserloginState');
  }

  Future<void> deleteUserLoginState() async {
    await _sharedPrefs.remove("UserloginState");
    //log.shout('Removed User Login State');
  }

  // Local Auth tells us if the user wants to use Secure Login /Local Authentication or not

  Future<void> setLocalAuthToken(bool accessLogin) async {
    await _sharedPrefs.setBool('LocalAuth', accessLogin);
    // notifyListeners();
  }

  bool? getLocalAuthToken() {
    return _sharedPrefs.getBool('LocalAuth');
  }

  Future<void> deleteLocalAuthToken() async {
    await _sharedPrefs.remove("LocalAuth");
    // notifyListeners();
  }

  bool? getNotificaitontokefast() {
    return _sharedPrefs.getBool('localnotifs');
  }

  bool? getPushNotificaitontokefast() {
    return _sharedPrefs.getBool('pushNotifs');
  }

// Theme token
  Future<void> setThemeToken(bool theme) async {
    await _sharedPrefs.setBool('Theme', theme);
  }

  bool? getThemeToken() {
    return _sharedPrefs.getBool('Theme');
  }

  //  Pin
  Future<void> setPin(String pin) async {
    await _sharedPrefs.setString('Pin', pin);
  }

  String? getPin() {
    return _sharedPrefs.getString('Pin');
  }

  Future<void> deleteThemeToken() async {
    await _sharedPrefs.remove("Theme");
  }

// Consent token
  Future<void> setConsentToken(bool theme) async {
    await _sharedPrefs.setBool('Consent', theme);
  }

  bool? getConsentToken() {
    return _sharedPrefs.getBool('Consent');
  }

  Future<void> deleteConsentToken() async {
    await _sharedPrefs.remove("Consent");
  }

  // Notifications token
  Future<void> setLocalNotficationsToken(bool theme) async {
    await _sharedPrefs.setBool('localnotifs', theme);
  }

  bool? getLocalNotficationsToken() {
    return _sharedPrefs.getBool('localnotifs');
  }

  Future<void> deleteLocalNotficationsToken() async {
    await _sharedPrefs.remove("localnotifs");
  }

  // Notifications token
  Future<void> setPushlNotficationsToken(bool theme) async {
    await _sharedPrefs.setBool('pushNotifs', theme);
  }

  bool? getPushNotficationsToken() {
    return _sharedPrefs.getBool('pushNotifs');
  }

  Future<void> deletePushNotficationsToken() async {
    await _sharedPrefs.remove("pushNotifs");
  }

  // deleting the navigator state management tokens
  Future<dynamic> deleteNavigatortokens() async {
    await _sharedPrefs.remove('tabstate');
    //await _sharedPrefs.remove('Consent');
    //await _sharedPrefs.remove('LocalAuth');
    await _sharedPrefs.remove('Theme');
    await _sharedPrefs.remove('UserloginState');
    await _sharedPrefs.remove("Patientstate");
    await _sharedPrefs.remove('localnotifs');
    await _sharedPrefs.remove("pushNotifs");
  }
}
