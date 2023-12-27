class SavePostResponse {
  int? id;
  String? userId;
  String? contentId;
  String? date;

  SavePostResponse({this.id, this.userId, this.contentId, this.date});

  SavePostResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    contentId = json['contentId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['contentId'] = contentId;
    data['date'] = date;
    return data;
  }
}
