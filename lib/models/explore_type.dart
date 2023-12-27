// ignore_for_file: unused_local_variable

class ExploreType {
  ExploreType(
      {required this.title,
      required this.text,
      required this.headerImage,
      required this.thumbImage,
      required this.author,
      required this.tags,
      required this.meals,
      this.authorImage});
  late final String title;
  late final String text;
  late final String? headerImage;
  late final String? thumbImage;
  late final String author;
  late final List<String> tags;
  late final List<String> meals;
  late final String? authorImage;

  ExploreType.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    headerImage = json['headerImage'];
    thumbImage = json['thumbImage'];
    author = json['author'];
    tags = List.castFrom<dynamic, String>(json['tags']);
    meals = List.castFrom<dynamic, String>(json['Meal type']);
    authorImage = json['authorImage'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['text'] = text;
    data['headerImage'] = headerImage;
    data['thumbImage'] = thumbImage;
    data['author'] = author;
    data['tags'] = tags;
    data['Meal type'] = meals;
    data['authorImage'] = authorImage;
    return data;
  }
}
