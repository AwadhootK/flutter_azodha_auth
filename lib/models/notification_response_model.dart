import 'dart:convert';

class NotificationResponseModel {
  int? id;
  String? messageTitle;
  String? messageBody;
  int? consumerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationResponseModel({
    this.id,
    this.messageTitle,
    this.messageBody,
    this.consumerId,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationResponseModel.fromRawJson(String str) =>
      NotificationResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationResponseModel(
        id: json["id"],
        messageTitle: json["messageTitle"] ?? '',
        messageBody: json["messageBody"] ?? '',
        consumerId: json["consumerId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "messageTitle": messageTitle,
        "messageBody": messageBody,
        "consumerId": consumerId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
