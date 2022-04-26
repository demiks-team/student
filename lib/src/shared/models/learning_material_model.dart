import 'dart:convert';

List<LearningMaterialModel> learningMaterialFromJson(String str) =>
    List<LearningMaterialModel>.from(
        json.decode(str).map((x) => LearningMaterialModel.fromJson(x)));
String learningMaterialToJson(List<LearningMaterialModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LearningMaterialModel {
  LearningMaterialModel({
    required this.id,
    this.title,
    this.description,
    this.body,
    this.estimatedStudyTime,
    this.guid,
  });
  int id;
  String? title;
  String? description;
  String? body;
  int? estimatedStudyTime;
  String? guid;
  factory LearningMaterialModel.fromJson(Map<String, dynamic> json) =>
      LearningMaterialModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        body: json["body"],
        estimatedStudyTime: json["estimatedStudyTime"],
        guid: json["guid"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "body": body,
        "estimatedStudyTime": estimatedStudyTime,
        "guid": guid,
      };
}
