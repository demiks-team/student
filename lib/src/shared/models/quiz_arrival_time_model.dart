import 'dart:convert';

List<QuizArrivalTimeModel> quizArrivalTimeModelFromJson(String str) =>
    List<QuizArrivalTimeModel>.from(
        json.decode(str).map((x) => QuizArrivalTimeModel.fromJson(x)));
String quizArrivalTimeModelToJson(List<QuizArrivalTimeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizArrivalTimeModel {
  QuizArrivalTimeModel(
      {this.studentId, required this.quizId, required this.arrivalTime});
  int? studentId;
  int quizId;
  String arrivalTime;

  factory QuizArrivalTimeModel.fromJson(Map<String, dynamic> json) =>
      QuizArrivalTimeModel(
          studentId: json["studentId"],
          quizId: json["quizId"],
          arrivalTime: json["arrivalTime"]);
  Map<String, dynamic> toJson() =>
      {"studentId": studentId, "quizId": quizId, "arrivalTime": arrivalTime};
}
