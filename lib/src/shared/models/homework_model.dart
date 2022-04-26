import 'dart:convert';


List<HomeworkModel> homeWorkFromJson(String str) =>
    List<HomeworkModel>.from(
        json.decode(str).map((x) => HomeworkModel.fromJson(x)));
String homeWorkToJson(List<HomeworkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeworkModel {
  HomeworkModel({
    required this.id,
    this.createdOn,
    this.groupId,
    this.deadline,
    this.description,
    this.grade,
  });
  int id;
  String? createdOn;
  int? groupId;
  String? deadline;
  String? description;
  int? grade;

  factory HomeworkModel.fromJson(Map<String, dynamic> json) =>
      HomeworkModel(
        id: json["id"],
        createdOn: json["createdOn"],
        groupId: json["groupId"],
        deadline: json["deadline"],
        description: json["description"],
        grade: json["grade"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "createdOn": createdOn,
        "groupId": groupId,
        "deadline": deadline,
        "description": description,
        "grade": grade,
      };
}
