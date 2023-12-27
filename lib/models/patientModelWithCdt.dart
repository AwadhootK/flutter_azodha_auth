import 'package:json_annotation/json_annotation.dart';

part 'patientModelWithCdt.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientModelWithCdt {
  PatientModelWithCdt({
    required this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.timeZone,
    this.gender,
    this.birthDate,
    this.addressLine1,
    this.addressLine2,
    this.zipCode,
    this.mobileNumber,
    this.email,
    this.mrn,
    this.department,
    this.regionName,
    this.territory,
    this.patientPrograms,
    this.cdts,
    this.dependants,
  });

  String id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? timeZone;
  String? gender;
  DateTime? birthDate;
  String? addressLine1;
  String? addressLine2;
  String? zipCode;
  String? mobileNumber;
  String? email;
  String? mrn;
  String? department;
  String? regionName;
  String? territory;
  List<PatientProgram>? patientPrograms;
  List<Cdt>? cdts;
  List<dynamic>? dependants;

  factory PatientModelWithCdt.fromJson(Map<String, dynamic> json) =>
      _$PatientModelWithCdtFromJson(json);

  Map<String, dynamic> toJson() => _$PatientModelWithCdtToJson(this);

  PatientModelWithCdt copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? middleName,
    String? timeZone,
    String? gender,
    DateTime? birthDate,
    String? addressLine1,
    String? addressLine2,
    String? zipCode,
    String? mobileNumber,
    String? email,
    String? mrn,
    String? department,
    String? regionName,
    String? territory,
    List<PatientProgram>? patientPrograms,
    List<Cdt>? cdts,
    List<dynamic>? dependants,
  }) {
    return PatientModelWithCdt(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      timeZone: timeZone ?? this.timeZone,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      zipCode: zipCode ?? this.zipCode,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      mrn: mrn ?? this.mrn,
      department: department ?? this.department,
      regionName: regionName ?? this.regionName,
      territory: territory ?? this.territory,
      patientPrograms: patientPrograms ?? this.patientPrograms,
      cdts: cdts ?? this.cdts,
      dependants: dependants ?? this.dependants,
    );
  }
}

@JsonSerializable()
class Cdt {
  Cdt({
    required this.name,
    required this.records,
  });

  String name;
  List<dynamic> records;

  factory Cdt.fromJson(Map<String, dynamic> json) => _$CdtFromJson(json);

  Map<String, dynamic> toJson() => _$CdtToJson(this);

  Cdt copyWith({
    String? name,
    List<dynamic>? records,
  }) =>
      Cdt(
        name: name ?? this.name,
        records: records ?? this.records,
      );
}

@JsonSerializable()
class PatientProgram {
  PatientProgram({
    required this.id,
    required this.createdByName,
    required this.createdAt,
    required this.updatedByName,
    required this.updatedAt,
    required this.programName,
    required this.programTitle,
    required this.programDescription,
    required this.assigned,
    required this.patientId,
    required this.currentPhase,
    required this.status,
    required this.compatibleWithCurrentVersion,
    required this.pathHistory,
  });

  String id;
  String? createdByName;
  DateTime? createdAt;
  String? updatedByName;
  DateTime? updatedAt;
  String? programName;
  String? programTitle;
  String? programDescription;
  bool? assigned;
  String? patientId;
  CurrentPhase? currentPhase;
  String? status;
  bool? compatibleWithCurrentVersion;
  List<CurrentPhase> pathHistory;

  factory PatientProgram.fromJson(Map<String, dynamic> json) =>
      _$PatientProgramFromJson(json);

  Map<String, dynamic> toJson() => _$PatientProgramToJson(this);
}

@JsonSerializable()
class CurrentPhase {
  CurrentPhase({
    required this.timestamp,
    required this.createdBy,
    required this.createdByName,
    required this.name,
    required this.title,
    required this.description,
    required this.currentVersion,
    required this.deleted,
  });

  DateTime? timestamp;
  String? createdBy;
  String? createdByName;
  String? name;
  String? title;
  String? description;
  String? currentVersion;
  bool? deleted;

  factory CurrentPhase.fromJson(Map<String, dynamic> json) =>
      _$CurrentPhaseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentPhaseToJson(this);
}
