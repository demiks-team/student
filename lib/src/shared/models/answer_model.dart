import 'dart:convert';

List<AnswerModel> answerFromJson(String str) => List<AnswerModel>.from(
    json.decode(str).map((x) => AnswerModel.fromJson(x)));
String answerToJson(List<AnswerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnswerModel {
  AnswerModel({required this.id, required this.questionId, this.answerText});
  int id;
  int questionId;
  String? answerText;

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
      id: json["id"],
      questionId: json["questionId"],
      answerText: json["answerText"]);
  Map<String, dynamic> toJson() =>
      {"id": id, "questionId": questionId, "answerText": answerText};
}
