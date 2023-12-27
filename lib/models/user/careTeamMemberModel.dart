import 'dart:convert';

class CareTeamMemberModel {
  CareTeamMemberModel({
    this.id,
    this.patientId,
    this.isChatEnabled,
    this.participants,
  });

  String? id;
  String? patientId;
  bool? isChatEnabled;
  List<Participant>? participants;

  factory CareTeamMemberModel.fromRawJson(String str) =>
      CareTeamMemberModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CareTeamMemberModel.fromJson(Map<String, dynamic> json) =>
      CareTeamMemberModel(
        id: json["id"],
        patientId: json["patientId"],
        isChatEnabled: json["isChatEnabled"],
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientId": patientId,
        "isChatEnabled": isChatEnabled,
        "participants":
            List<dynamic>.from(participants!.map((x) => x.toJson())),
      };
}

class Participant {
  Participant({
    this.id,
    this.firstName,
    this.lastName,
    this.roles,
    this.isChatEnabled,
  });

  String? id;
  String? firstName;
  String? lastName;
  List<String>? roles;
  bool? isChatEnabled;

  factory Participant.fromRawJson(String str) =>
      Participant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        isChatEnabled: json["isChatEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "roles": List<dynamic>.from(roles!.map((x) => x)),
        "isChatEnabled": isChatEnabled,
      };
}
