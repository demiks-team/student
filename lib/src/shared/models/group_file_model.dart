import 'dart:convert';

List<GroupFileModel> groupFileFromJson(String str) =>
    List<GroupFileModel>.from(
        json.decode(str).map((x) => GroupFileModel.fromJson(x)));
String groupFileToJson(List<GroupFileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupFileModel {
  GroupFileModel({
    this.fileName,
    this.fileType,
    this.description,
    this.displayOrder,
    this.estimatedStudyTime,
    this.fileGuid,
  });
  String? fileName;
  int? fileType;
  String? description;
  int? displayOrder;
  int? estimatedStudyTime;
  String? fileGuid;
  factory GroupFileModel.fromJson(Map<String, dynamic> json) =>
      GroupFileModel(
        fileName: json["fileName"],
        fileType: json["fileType"],
        description: json["description"],
        displayOrder: json["displayOrder"],
        estimatedStudyTime: json["estimatedStudyTime"],
        fileGuid: json["fileGuid"],
      );
  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileType": fileType,
        "description": description,
        "displayOrder": displayOrder,
        "estimatedStudyTime": estimatedStudyTime,
        "fileGuid": fileGuid,
      };
}
