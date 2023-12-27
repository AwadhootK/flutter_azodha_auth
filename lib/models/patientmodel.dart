import 'package:json_annotation/json_annotation.dart';
part 'patientmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientModel {
  PatientModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.gender,
    this.birthDate,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.mobileNumber,
    this.email,
    this.dependant,
  });

  String id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? gender;
  DateTime? birthDate;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? zipCode;
  String? country;
  String? mobileNumber;
  String? email;
  List<PatientModel>? dependant;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}
