// To parse this JSON data, do
//
//     final consentModel = consentModelFromJson(jsonString);

import 'dart:convert';

class ConsentModel {
  String? id;
  dynamic icon;
  dynamic cover;
  String? title;
  String? description;

  DateTime? createdTime;
  DateTime? lastEditedTime;

  ConsentModel({
    this.id,
    this.icon,
    this.cover,
    this.title,
    this.description,
    this.createdTime,
    this.lastEditedTime,
  });

  factory ConsentModel.fromRawJson(String str) =>
      ConsentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConsentModel.fromJson(Map<String, dynamic> json) => ConsentModel(
        id: json["id"],
        icon: json["icon"],
        cover: json["cover"],
        title: json["title"],
        description: json["description"],
        createdTime: json["created_time"] == null
            ? null
            : DateTime.parse(json["created_time"]),
        lastEditedTime: json["last_edited_time"] == null
            ? null
            : DateTime.parse(json["last_edited_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
        "cover": cover,
        "title": title,
        "description": description,
        "created_time": createdTime?.toIso8601String(),
        "last_edited_time": lastEditedTime?.toIso8601String(),
      };
}
