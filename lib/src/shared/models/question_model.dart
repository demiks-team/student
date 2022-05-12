import 'dart:convert';

import 'package:student/src/shared/models/answer_model.dart';

List<QuestionModel> questionFromJson(String str) => List<QuestionModel>.from(
    json.decode(str).map((x) => QuestionModel.fromJson(x)));
String questionToJson(List<QuestionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionModel {
  QuestionModel(
      {required this.id,
      this.createdOn,
      required this.quizId,
      required this.teacherUserId,
      this.questionText,
      required this.points,
      this.answers,
      this.isAnswered});
  int id;
  int quizId;
  int teacherUserId;
  String? createdOn;
  String? questionText;
  double points;
  List<AnswerModel>? answers;
  bool? isAnswered;

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
      id: json["id"],
      createdOn: json["createdOn"],
      quizId: json["quizId"],
      teacherUserId: json["teacherUserId"],
      questionText: json["questionText"],
      points: json["points"],
      answers: json["answers"] != null
          ? (json["answers"] as List)
              .map(
                (dynamic item) => AnswerModel.fromJson(item),
              )
              .toList()
          : null,
      isAnswered: json["isAnswered"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "createdOn": createdOn,
        "quizId": quizId,
        "teacherUserId": teacherUserId,
        "questionText": questionText,
        "points": points,
        "answers": answers,
        "isAnswered": isAnswered
      };
}
