import 'package:json_annotation/json_annotation.dart';
// To parse this JSON data, do
//
//     final getBlogsModel = getBlogsModelFromJson(jsonString);

import 'dart:convert';

class GetBlogsModel {
  String id;
  String? title;
  dynamic icon;
  dynamic cover;
  DateTime? createdTime;
  DateTime? lastEditedTime;
  Properties? properties;

  GetBlogsModel({
    required this.id,
    this.title,
    this.icon,
    this.cover,
    this.createdTime,
    this.lastEditedTime,
    this.properties,
  });

  factory GetBlogsModel.fromRawJson(String str) =>
      GetBlogsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBlogsModel.fromJson(Map<String, dynamic> json) => GetBlogsModel(
        id: json["id"],
        title: json["title"],
        icon: json["icon"],
        cover: json["cover"],
        createdTime: json["created_time"] == null
            ? null
            : DateTime.parse(json["created_time"]),
        lastEditedTime: json["last_edited_time"] == null
            ? null
            : DateTime.parse(json["last_edited_time"]),
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
        "cover": cover,
        "created_time": createdTime?.toIso8601String(),
        "last_edited_time": lastEditedTime?.toIso8601String(),
        "properties": properties?.toJson(),
      };
}

class Properties {
  String? author;
  List<Category>? categories;
  List<String>? image;
  List<String>? authorProfile;
  Date? date;
  String? name;

  Properties({
    this.author,
    this.categories,
    this.image,
    this.authorProfile,
    this.date,
    this.name,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        author: json["Author"],
        categories: json["Categories"] == null
            ? []
            : List<Category>.from(
                json["Categories"]!.map((x) => Category.fromJson(x))),
        image: json["Image"] == null
            ? []
            : List<String>.from(json["Image"]!.map((x) => x)),
        authorProfile: json["Author Profile"] == null
            ? []
            : List<String>.from(json["Author Profile"]!.map((x) => x)),
        date: json["Date"] == null ? null : Date.fromJson(json["Date"]),
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Author": author,
        "Categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "Image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "Author Profile": authorProfile == null
            ? []
            : List<dynamic>.from(authorProfile!.map((x) => x)),
        "Date": date?.toJson(),
        "Name": name,
      };
}

class Category {
  String? id;
  String? name;
  String? color;

  Category({
    this.id,
    this.name,
    this.color,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
      };
}

class Date {
  DateTime? start;
  dynamic end;
  dynamic timeZone;

  Date({
    this.start,
    this.end,
    this.timeZone,
  });

  factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"],
        timeZone: json["time_zone"],
      );

  Map<String, dynamic> toJson() => {
        "start":
            "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "end": end,
        "time_zone": timeZone,
      };
}
