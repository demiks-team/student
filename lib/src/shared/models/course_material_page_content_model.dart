import 'dart:convert';
import 'package:student/src/shared/models/learning_material_tag_model.dart';

import 'enums.dart';

List<CourseMaterialPageContentModel> paymentFromJson(String str) =>
    List<CourseMaterialPageContentModel>.from(json
        .decode(str)
        .map((x) => CourseMaterialPageContentModel.fromJson(x)));
String paymentToJson(List<CourseMaterialPageContentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseMaterialPageContentModel {
  CourseMaterialPageContentModel(
      {required this.id,
      this.schoolId,
      this.teacherUserId,
      this.title,
      this.body,
      this.contentType,
      this.createdOn,
      this.description,
      this.fileType,
      this.fileSize,
      this.fileNameOnServer,
      this.isPublic,
      this.levelOfSharingCourseMaterial,
      this.allowedSchools,
      this.estimatedStudyTime,
      this.skillId,
      this.levelId,
      this.courseMaterialPageContentTagss
      });
  int id;
  int? schoolId;
  int? teacherUserId;
  String? title;
  String? body;
  CourseMaterialPageContentType? contentType;
  String? createdOn;
  String? description;
  FileType? fileType;
  int? fileSize;
  String? fileNameOnServer;
  bool? isPublic;
  LevelOfSharingCourseMaterial? levelOfSharingCourseMaterial;
  String? allowedSchools;
  int? estimatedStudyTime;
  ProgramSkill? skillId;
  ProgramLevel? levelId;
  List<LearningMaterialTagModel>? courseMaterialPageContentTagss;
  factory CourseMaterialPageContentModel.fromJson(Map<String, dynamic> json) =>
      CourseMaterialPageContentModel(
        id: json["id"],
        schoolId: json["schoolId"],
        teacherUserId: json["teacherUserId"],
        title: json["title"],
        body: json["body"],
        contentType: json["contentType"] != null
            ? CourseMaterialPageContentType.values[json["contentType"]]
            : null,
        createdOn: json["createdOn"],
        description: json["description"],
        fileType:
            json["fileType"] != null ? FileType.values[json["fileType"]] : null,
        fileSize: json["fileSize"],
        fileNameOnServer: json["fileNameOnServer"],
        isPublic: json["isPublic"],
        levelOfSharingCourseMaterial:
            json["levelOfSharingCourseMaterial"] != null
                ? LevelOfSharingCourseMaterial
                    .values[json["levelOfSharingCourseMaterial"]]
                : null,
        allowedSchools: json["allowedSchools"],
        estimatedStudyTime: json["estimatedStudyTime"],
        skillId: json["skillId"] != null
            ? ProgramSkill.values[json["skillId"]]
            : null,
        levelId: json["levelId"] != null
            ? ProgramLevel.values[json["levelId"]]
            : null,
        courseMaterialPageContentTagss:
            json["courseMaterialPageContentTagss"] != null
                ? (json["courseMaterialPageContentTagss"] as List)
                    .map(
                      (dynamic item) => LearningMaterialTagModel.fromJson(item),
                    )
                    .toList()
                : null,
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "schoolId": schoolId,
        "teacherUserId": teacherUserId,
        "title": title,
        "body": body,
        "contentType": contentType,
        "createdOn": createdOn,
        "description": description,
        "fileType": fileType,
        "fileSize": fileSize,
        "fileNameOnServer": fileNameOnServer,
        "isPublic": isPublic,
        "levelOfSharingCourseMaterial": levelOfSharingCourseMaterial,
        "allowedSchools": allowedSchools,
        "estimatedStudyTime": estimatedStudyTime,
        "skillId": skillId,
        "levelId": levelId,
        if (courseMaterialPageContentTagss != null)
          "courseMaterialPageContentTagss": courseMaterialPageContentTagss
      };
}
