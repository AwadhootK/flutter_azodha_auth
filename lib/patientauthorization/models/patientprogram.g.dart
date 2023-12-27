// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientprogram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Programme _$ProgrammeFromJson(Map<String, dynamic> json) => Programme(
      name: json['name'] as String,
      description: json['description'] as String,
      title: json['title'] as String,
      status: json['status'] as String?,
      currentPhase: json['currentPhase'] as String?,
    );

Map<String, dynamic> _$ProgrammeToJson(Programme instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'title': instance.title,
      'status': instance.status,
      'currentPhase': instance.currentPhase,
    };
