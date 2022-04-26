import 'dart:convert';

import 'package:student/src/shared/models/session_summary_model.dart';

import 'quiz_model.dart';

List<QuizGradeModel> quizGradeFromJson(String str) => List<QuizGradeModel>.from(
    json.decode(str).map((x) => QuizGradeModel.fromJson(x)));
String quizGradeToJson(List<QuizGradeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizGradeModel {
  QuizGradeModel({
    this.studentId,
    this.quizId,
    this.quiz,
    this.grade,
  });
  int? studentId;
  int? quizId;
  QuizModel? quiz;
  double? grade;
  List<SessionSummaryModel>? sessions;
  factory QuizGradeModel.fromJson(Map<String, dynamic> json) => QuizGradeModel(
      studentId: json["studentId"],
      quizId: json["quizId"],
      grade: json["grade"],
      quiz: QuizModel?.fromJson(json["quiz"]));
  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "quizId": quizId,
        "grade": grade,
        "quiz": quiz?.toJson()
      };
}
