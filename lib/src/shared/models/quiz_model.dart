import 'dart:convert';

import 'package:student/src/shared/models/session_summary_model.dart';

List<QuizModel> quizFromJson(String str) =>
    List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));
String quizToJson(List<QuizModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizModel {
  QuizModel({
    required this.id,
    this.createdOn,
    this.startDateTime,
    this.endDateTime,
    this.durationInMinutes,
    this.totalPoint,
  });
  int id;
  String? createdOn;
  String? startDateTime;
  String? endDateTime;
  int? durationInMinutes;
  double? totalPoint;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json["id"],
        createdOn: json["createdOn"],
        startDateTime: json["startDateTime"],
        endDateTime: json["endDateTime"],
        durationInMinutes: json["durationInMinutes"],
        totalPoint: json["totalPoint"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "createdOn": createdOn,
        "startDateTime": startDateTime,
        "endDateTime": endDateTime,
        "durationInMinutes": durationInMinutes,
        "totalPoint": totalPoint,
      };
}
