import 'dart:convert';

List<SessionSummaryModel> sessionSummaryFromJson(String str) =>
    List<SessionSummaryModel>.from(
        json.decode(str).map((x) => SessionSummaryModel.fromJson(x)));
String sessionSummaryToJson(List<SessionSummaryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SessionSummaryModel {
  SessionSummaryModel({
    required this.sessionId,
    this.sessionDate,
    this.status,
    this.notesForStudent,
    this.sessionNumber,
    this.sessionStatus,
    this.teacherNote,
  });
  int sessionId;
  String? sessionDate;
  int? status;
  String? notesForStudent;
  int? sessionNumber;
  int? sessionStatus;
  String? teacherNote;
  factory SessionSummaryModel.fromJson(Map<String, dynamic> json) =>
      SessionSummaryModel(
        sessionId: json["sessionId"],
        sessionDate: json["sessionDate"],
        status: json["status"],
        notesForStudent: json["notesForStudent"],
        sessionNumber: json["sessionNumber"],
        sessionStatus: json["sessionStatus"],
        teacherNote: json["teacherNote"],
      );
  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "sessionDate": sessionDate,
        "status": status,
        "notesForStudent": notesForStudent,
        "sessionNumber": sessionNumber,
        "sessionStatus": sessionStatus,
        "teacherNote": teacherNote,
      };
}
