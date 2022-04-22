import 'dart:convert';

import 'learning_material_model.dart';

List<GroupLearningMaterialModel> groupLearningMaterialFromJson(String str) =>
    List<GroupLearningMaterialModel>.from(
        json.decode(str).map((x) => GroupLearningMaterialModel.fromJson(x)));
String groupLearningMaterialToJson(List<GroupLearningMaterialModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupLearningMaterialModel {
  GroupLearningMaterialModel({
    required this.learningMaterialId,
    required this.groupId,
    this.displayOrder,
    this.learningMaterial,
  });
  int learningMaterialId;
  int groupId;
  int? displayOrder;
  LearningMaterialModel? learningMaterial;
  factory GroupLearningMaterialModel.fromJson(Map<String, dynamic> json) =>
      GroupLearningMaterialModel(
        learningMaterialId: json["learningMaterialId"],
        groupId: json["groupId"],
        displayOrder: json["displayOrder"],
        learningMaterial: json["learningMaterial"] != null
            ? LearningMaterialModel.fromJson(json["learningMaterial"])
            : null,
      );
  Map<String, dynamic> toJson() => {
        "learningMaterialId": learningMaterialId,
        "groupId": groupId,
        "displayOrder": displayOrder,
        "learningMaterial":
            learningMaterial != null ? learningMaterial!.toJson() : null,
      };
}
