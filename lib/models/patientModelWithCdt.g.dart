// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientModelWithCdt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModelWithCdt _$PatientModelWithCdtFromJson(Map<String, dynamic> json) =>
    PatientModelWithCdt(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      middleName: json['middleName'] as String?,
      timeZone: json['timeZone'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      zipCode: json['zipCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      mrn: json['mrn'] as String?,
      department: json['department'] as String?,
      regionName: json['regionName'] as String?,
      territory: json['territory'] as String?,
      patientPrograms: (json['patientPrograms'] as List<dynamic>?)
          ?.map((e) => PatientProgram.fromJson(e as Map<String, dynamic>))
          .toList(),
      cdts: (json['cdts'] as List<dynamic>?)
          ?.map((e) => Cdt.fromJson(e as Map<String, dynamic>))
          .toList(),
      dependants: json['dependants'] as List<dynamic>?,
    );

Map<String, dynamic> _$PatientModelWithCdtToJson(
        PatientModelWithCdt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'timeZone': instance.timeZone,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'zipCode': instance.zipCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'mrn': instance.mrn,
      'department': instance.department,
      'regionName': instance.regionName,
      'territory': instance.territory,
      'patientPrograms':
          instance.patientPrograms?.map((e) => e.toJson()).toList(),
      'cdts': instance.cdts?.map((e) => e.toJson()).toList(),
      'dependants': instance.dependants,
    };

Cdt _$CdtFromJson(Map<String, dynamic> json) => Cdt(
      name: json['name'] as String,
      records: json['records'] as List<dynamic>,
    );

Map<String, dynamic> _$CdtToJson(Cdt instance) => <String, dynamic>{
      'name': instance.name,
      'records': instance.records,
    };

PatientProgram _$PatientProgramFromJson(Map<String, dynamic> json) =>
    PatientProgram(
      id: json['id'] as String,
      createdByName: json['createdByName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedByName: json['updatedByName'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      programName: json['programName'] as String?,
      programTitle: json['programTitle'] as String?,
      programDescription: json['programDescription'] as String?,
      assigned: json['assigned'] as bool?,
      patientId: json['patientId'] as String?,
      currentPhase: json['currentPhase'] == null
          ? null
          : CurrentPhase.fromJson(json['currentPhase'] as Map<String, dynamic>),
      status: json['status'] as String?,
      compatibleWithCurrentVersion:
          json['compatibleWithCurrentVersion'] as bool?,
      pathHistory: (json['pathHistory'] as List<dynamic>)
          .map((e) => CurrentPhase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PatientProgramToJson(PatientProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdByName': instance.createdByName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedByName': instance.updatedByName,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'programName': instance.programName,
      'programTitle': instance.programTitle,
      'programDescription': instance.programDescription,
      'assigned': instance.assigned,
      'patientId': instance.patientId,
      'currentPhase': instance.currentPhase,
      'status': instance.status,
      'compatibleWithCurrentVersion': instance.compatibleWithCurrentVersion,
      'pathHistory': instance.pathHistory,
    };

CurrentPhase _$CurrentPhaseFromJson(Map<String, dynamic> json) => CurrentPhase(
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      createdBy: json['createdBy'] as String?,
      createdByName: json['createdByName'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      currentVersion: json['currentVersion'] as String?,
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$CurrentPhaseToJson(CurrentPhase instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'createdBy': instance.createdBy,
      'createdByName': instance.createdByName,
      'name': instance.name,
      'title': instance.title,
      'description': instance.description,
      'currentVersion': instance.currentVersion,
      'deleted': instance.deleted,
    };
