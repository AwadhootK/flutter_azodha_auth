import 'package:azo_auth/models/notificationboxmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';

class NotificationBoxService extends ChangeNotifier {
  static late Box box;
  static late List<dynamic> notifs;
  static late List<dynamic> pushnotifs;
  static late int readcount;
  static final log = Logger('NotificationBoxService');
  static late ValueNotifier<int> notifier1;
  static late ValueNotifier<int> notifier2;

  static Future<void> init() async {
    Hive.registerAdapter(NotificationBoxModelAdapter());

    box = await Hive.openBox('savednotifications');
    try {
      notifs = await box.get(0) ?? [];
      readcount = await box.get(1) ?? 0;
      log.info(
          "Notification box initialised : ${notifs.length}  Readcount : $readcount");
      notifier1 = ValueNotifier(notifs.length);
      notifier2 = ValueNotifier(readcount);
    } catch (e) {
      log.info("Error initalising the Notificaiton box: ${e.toString()}");
      notifs = [];
      readcount = 0;
    }
  }

  // static List<dynamic> getSavedNotifs() {
  //   notifs = box.get(0) ?? [];
  //   log.info("Get saved notifs ${notifs.length}");
  //   return notifs;
  // }

  static Future<void> saveNotif(NotificationBoxModel notif) async {
    readcount = getReadCount();
    log.info("Save notif ${notif.message}  ${readcount}}");
    notifs.add(notif);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => notifier2.notifyListeners());
    await box.put(0, notifs);
  }

  static Future<void> saveReadCount() async {
    readcount = getAllNotifs().length;
    log.info("Save read count $readcount");

    await box.put(1, readcount);
  }

  static int getReadCount() {
    readcount = box.get(1) ?? 0;
    log.info("Get read count $readcount");
    return readcount;
  }

  static Future<void> deleteNotif(int index) async {
    notifs.removeAt(index);

    await box.put(0, notifs);
  }

  static Future<void> savePushNotif(
      List<NotificationBoxModel> pushnotifs) async {
    log.info("Saving push notifs ${pushnotifs.length}");
    notifs = pushnotifs;
    await box.put(2, pushnotifs);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => notifier2.notifyListeners());
  }

  static List<dynamic> getPushNotif() {
    pushnotifs = box.get(2) ?? [];
    log.info("Get push notifs ${pushnotifs.length}");
    return pushnotifs;
  }

  static Future<void> addPushNotifs(NotificationBoxModel notif) async {
    pushnotifs.add(notif);
    log.info("Add push notifs ${pushnotifs.length}");

    await box.put(2, pushnotifs);
  }

  static getAllNotifs() {
    List<dynamic> allnotifs = [];
    pushnotifs = box.get(2) ?? [];
    //notifs = box.get(0) ?? [];

    //allnotifs.addAll(notifs);
    allnotifs.addAll(pushnotifs);
    Set<NotificationBoxModel> uniqueSet =
        Set<NotificationBoxModel>.from(allnotifs);
    List<NotificationBoxModel> uniqueList = uniqueSet.toList();
    log.info("Get all notifs ${uniqueSet.length}");

    return uniqueList;
  }

  static Future clearbox() async {
    box.clear();
  }
}
