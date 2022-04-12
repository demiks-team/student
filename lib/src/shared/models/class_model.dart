import 'dart:convert';

List<Class> userFromJson(String str) =>
    List<Class>.from(json.decode(str).map((x) => Class.fromJson(x)));
String userToJson(List<Class> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Class {
  Class({
    required this.id,
    this.userId,
    this.title,
    this.body,
  });
  int id;
  int? userId;
  String? title;
  String? body;
  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        body: json["body"],
      );
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
