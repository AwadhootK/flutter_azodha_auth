import 'package:hive_flutter/hive_flutter.dart';

part 'notificationboxmodel.g.dart';

@HiveType(typeId: 3)
class NotificationBoxModel extends HiveObject {
  @HiveField(0)
  late DateTime time;

  @HiveField(1)
  late String message;
}
