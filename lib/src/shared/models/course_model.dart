import 'dart:convert';

List<CourseModel> courseFromJson(String str) => List<CourseModel>.from(
    json.decode(str).map((x) => CourseModel.fromJson(x)));
String courseToJson(List<CourseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseModel {
  CourseModel({
    required this.id,
    this.name,
  });
  int id;
  String? name;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        name: json["name"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
