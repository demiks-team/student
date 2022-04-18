import 'dart:convert';

List<TeacherModel> teacherFromJson(String str) => List<TeacherModel>.from(
    json.decode(str).map((x) => TeacherModel.fromJson(x)));
String teacherToJson(List<TeacherModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherModel {
  TeacherModel({
    required this.id,
    this.fullName,
  });
  int id;
  String? fullName;

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        id: json["id"],
        fullName: json["fullName"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
      };
}
