import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String? middleName;

  @HiveField(4)
  String? gender;

  @HiveField(6)
  String? patientid;

  @HiveField(7)
  DateTime? birthDate;

  @HiveField(8)
  String? addressLine1;

  @HiveField(9)
  String? addressLine2;

  @HiveField(10)
  String? city;

  @HiveField(11)
  String? state;

  @HiveField(12)
  String? zipCode;

  @HiveField(13)
  String? country;

  @HiveField(14)
  String? phone;

  @HiveField(15)
  String? email;

  @HiveField(16)
  String? name;
}
