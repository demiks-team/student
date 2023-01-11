import 'dart:convert';

List<LearningMaterialTagModel> roomFromJson(String str) =>
    List<LearningMaterialTagModel>.from(json.decode(str).map((x) => LearningMaterialTagModel.fromJson(x)));
String roomToJson(List<LearningMaterialTagModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LearningMaterialTagModel {
  LearningMaterialTagModel({
    required this.id,
    this.title,
  });
  int id;
  String? title;

  factory LearningMaterialTagModel.fromJson(Map<String, dynamic> json) => LearningMaterialTagModel(
        id: json["id"],
        title: json["title"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
