import 'dart:convert';

import 'package:student/src/shared/models/group_model.dart';
import 'package:student/src/shared/models/session_summary_model.dart';

List<QuizModel> quizFromJson(String str) =>
    List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));
String quizToJson(List<QuizModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizModel {
  QuizModel(
      {required this.id,
      this.createdOn,
      this.startDateTime,
      this.endDateTime,
      this.durationInMinutes,
      this.totalPoint,
      this.groupId,
      this.group,
      this.title,
      required this.isOnline,
      required this.displayCorrectAnswer});
  int id;
  String? createdOn;
  int? groupId;
  GroupModel? group;
  String? title;
  bool isOnline;
  String? startDateTime;
  String? endDateTime;
  int? durationInMinutes;
  double? totalPoint;
  bool displayCorrectAnswer;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
      id: json["id"],
      createdOn: json["createdOn"],
      startDateTime: json["startDateTime"],
      endDateTime: json["endDateTime"],
      durationInMinutes: json["durationInMinutes"],
      totalPoint: json["totalPoint"],
      groupId: json["groupId"],
      group: json["group"] != null ? GroupModel.fromJson(json["group"]) : null,
      title: json["title"],
      isOnline: json["isOnline"],
      displayCorrectAnswer: json["displayCorrectAnswer"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "createdOn": createdOn,
        "startDateTime": startDateTime,
        "endDateTime": endDateTime,
        "durationInMinutes": durationInMinutes,
        "totalPoint": totalPoint,
        "groupId": groupId,
        "group": group,
        "title": title,
        "isOnline": isOnline,
        "displayCorrectAnswer": displayCorrectAnswer
      };
}
