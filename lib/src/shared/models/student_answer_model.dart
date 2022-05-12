import 'dart:convert';

import 'package:student/src/shared/models/question_model.dart';

List<StudentAnswerModel> studentAnswerFromJson(String str) =>
    List<StudentAnswerModel>.from(
        json.decode(str).map((x) => StudentAnswerModel.fromJson(x)));
String studentAnswerToJson(List<StudentAnswerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentAnswerModel {
  StudentAnswerModel(
      {this.studentId, this.questionId, this.question, this.answerIndex});
  int? studentId;
  int? questionId;
  QuestionModel? question;
  int? answerIndex;

  factory StudentAnswerModel.fromJson(Map<String, dynamic> json) =>
      StudentAnswerModel(
          studentId: json["studentId"],
          questionId: json["questionId"],
          question: json["question"] != null
              ? QuestionModel.fromJson(json["question"])
              : null,
          answerIndex: json["answerIndex"]);
  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "questionId": questionId,
        "question": question,
        "answerIndex": answerIndex
      };
}
