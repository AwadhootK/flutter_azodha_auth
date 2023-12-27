import 'package:json_annotation/json_annotation.dart';

part 'patientprogram.g.dart';

@JsonSerializable()
class Programme {
  final String name;
  final String description;
  final String title;
  final String? status;
  final String? currentPhase;

  Programme({
    required this.name,
    required this.description,
    required this.title,
    this.status,
    this.currentPhase,
  });

  factory Programme.fromJson(Map<String, dynamic> json) =>
      _$ProgrammeFromJson(json);

  Map<String, dynamic> toJson() => _$ProgrammeToJson(this);
}
