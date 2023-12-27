import 'dart:developer' as dz;
import 'dart:math';

import 'package:azo_auth/core/api_layer/clients/sharedpreferences_client.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/db/shared_preferences_manager.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:azo_auth/models/notificationboxmodel.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart' as badger;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;

import 'package:logging/logging.dart';

import 'notification_box_service.dart';

class NotificationService {
  final Config config;

  NotificationService({required this.config});

  int id = 0;
  static onNotifHandler(NotificationResponse details) async {
    badger.FlutterAppBadger.updateBadgeCount(1);
  }

  SharedPreferencesManager sharedPreferencesManager = AuthDependencyInjector
      .getIt
      .get<SharedPreferencesManagerClient>()
      .sharedPreferencesManager;

  // final HabitRepository habitRepository =
  //     AuthDependencyInjector.getIt.get<HabitRepository>();
  final log = Logger('LocalNotificationService');

  final List<String> habitLogMessages = [
    "Take a minute to log your habits 🌱",
    "Tap to log, small steps go a long way 👣",
    "How's habit building? Tell your coach 💭",
    "Small wins count, log your habits now",
    "Update your habits to keep track ✏",
    "🕒 It's habit logging time!",
    "Small steps, big impact. Log now!",
    "One habit at a time. Log now",
    "Your efforts matter 💪 Log them!",
    "Celebrate each step. Log now!",
    "Log your habits to remember them",
    "Updated your habit log yet?",
    "Stay motivated, log your journey",
    "Logged your habits yet? ✅",
    "Track your progress, log your habits ✅",
    "Remember to update your progress!",
    "Stay accountable log your habits 🤝",
    "Small habits build change. Log today",
    "Remember to log your habits!",
  ];

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configureLocalTimeZone() async {
    log.info('Configuring Local Time Zone');
    tzl.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> cancelAllNotifications() async {
    log.info('Cancelling all notifications');
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> setupScheduledNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    log.info('setupScheduledNotifications');
    tzl.initializeTimeZones();
    // Set the local time zone

    final timezone = await FlutterNativeTimezone.getLocalTimezone();
    final location = tz.getLocation(timezone);

    // Get the current date and time
    final currentDate = tz.TZDateTime.now(location);

    // Generate the list of scheduled times
    final scheduledTimes = generateScheduledTimes(currentDate);

    //Print the scheduled times
    scheduledTimes.forEach((time) async {
      dz.log(time.toString());
      await sendNotification(time, null);
    });
  }

  List<tz.TZDateTime> generateScheduledTimes(tz.TZDateTime currentDate) {
    final scheduledTimes = <tz.TZDateTime>[];

    // Find the next Tuesday
    tz.TZDateTime nextTuesday = currentDate;
    while (nextTuesday.weekday != DateTime.tuesday) {
      nextTuesday = nextTuesday.add(const Duration(days: 1));
    }
    nextTuesday = tz.TZDateTime(nextTuesday.location, nextTuesday.year,
        nextTuesday.month, nextTuesday.day, 19);

    // Find the next Saturday
    tz.TZDateTime nextSaturday = currentDate;
    while (nextSaturday.weekday != DateTime.saturday) {
      nextSaturday = nextSaturday.add(const Duration(days: 1));
    }
    nextSaturday = tz.TZDateTime(nextSaturday.location, nextSaturday.year,
        nextSaturday.month, nextSaturday.day, 19);

    // Add scheduled times for the next 10 occurrences
    for (var i = 0; i < 10; i++) {
      scheduledTimes.add(nextTuesday);
      scheduledTimes.add(nextSaturday);

      // Increment to the next Tuesday and Saturday
      nextTuesday = nextTuesday.add(const Duration(days: 7));
      nextSaturday = nextSaturday.add(const Duration(days: 7));
    }

    return scheduledTimes;
  }

  Future sendNotification(tz.TZDateTime? time, Duration? duration) async {
    final Random random = Random();
    final int randomIndex = random.nextInt(habitLogMessages.length);

    final String selectedMessage = habitLogMessages[randomIndex];
    tz.TZDateTime scheduledDate = time ??
        tz.TZDateTime.now(tz.local).add(duration ?? const Duration(seconds: 5));
    log.info('sendNotification: $scheduledDate');
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      config.appName,
      selectedMessage,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "channelId",
          "channelName",
          icon: "app_icon",
          priority: Priority.max,
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    id = id + 1;
    NotificationBoxModel notif = NotificationBoxModel()
      ..time = DateTime(
        time?.year ?? DateTime.now().year,
        time?.month ?? DateTime.now().month,
        time?.day ?? DateTime.now().month,
        time?.hour ?? DateTime.now().month,
        time?.minute ?? DateTime.now().month,
        time?.second ?? DateTime.now().month,
      )
      ..message = selectedMessage;

    // !! - check what to do with local notifs
    //await NotificationBoxService.saveNotif(notif);
  }

  Future<void> initializeFlutterLocalNotificationsPlugin() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      'app_icon',
    );

    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        badger.FlutterAppBadger.updateBadgeCount(1);
      },
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onNotifHandler,
      onDidReceiveNotificationResponse: onNotifHandler,
    );
  }

  // Future instantNotification() async {
  //   await flutterLocalNotificationsPlugin.show(
  //     DateTime.now().millisecond,
  //     "message.notification?.title",
  //     "message.notification?.body",
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         "channelId",
  //         "channelName",
  //         icon: "app_icon",
  //         priority: Priority.max,
  //         importance: Importance.max,
  //         enableVibration: true,
  //       ),
  //       iOS: DarwinNotificationDetails(
  //         presentAlert: true,
  //         presentBadge: false,
  //         presentSound: false,
  //       ),
  //     ),
  //     payload: "json.encode(message.data)",
  //   );
  // }

  // Future setLocalNotifications(bool value) async {
  //   dz.log('Value : $value');

  //   if (value == false) {
  //     await cancelAll();
  //     return;
  //   }
  //   dz.log(habitRepository.careTaskModels.length.toString());
  //   bool active = false;
  //   for (var goal in habitRepository.careTaskModels) {
  //     if (goal.status == "ACTIVE") {
  //       active = true;
  //     }
  //   }
  //   if (active) {
  //     log.info(
  //         'settingupScheduledNotifications : Cancelling all notifications');
  //     await setupScheduledNotifications();
  //   } else {
  //     log.info('setLocalNotifications : Cancelling all notifications');
  //     await cancelAll();
  //   }
  // }

  cancelAll() async => await flutterLocalNotificationsPlugin.cancelAll();
  cancel(id) async => await flutterLocalNotificationsPlugin.cancel(id);
}
