import 'dart:convert';

import 'enums.dart';

List<SessionSummaryModel> sessionSummaryFromJson(String str) =>
    List<SessionSummaryModel>.from(
        json.decode(str).map((x) => SessionSummaryModel.fromJson(x)));
String sessionSummaryToJson(List<SessionSummaryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SessionSummaryModel {
  SessionSummaryModel(
      {required this.sessionId,
      this.sessionDate,
      this.status,
      this.notesForStudent,
      this.sessionNumber,
      this.sessionStatus,
      this.teacherNote,
      this.isCancellationRequested});
  int sessionId;
  String? sessionDate;
  int? status;
  String? notesForStudent;
  int? sessionNumber;
  GroupSessionStatus? sessionStatus;
  String? teacherNote;
  bool? isCancellationRequested;
  factory SessionSummaryModel.fromJson(Map<String, dynamic> json) =>
      SessionSummaryModel(
          sessionId: json["sessionId"],
          sessionDate: json["sessionDate"],
          status: json["status"],
          notesForStudent: json["notesForStudent"],
          sessionNumber: json["sessionNumber"],
          sessionStatus: json["sessionStatus"] != null
              ? GroupSessionStatus.values[json["sessionStatus"]]
              : null,
          teacherNote: json["teacherNote"],
          isCancellationRequested: json["isCancellationRequested"]);
  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "sessionDate": sessionDate,
        "status": status,
        "notesForStudent": notesForStudent,
        "sessionNumber": sessionNumber,
        "sessionStatus": sessionStatus,
        "teacherNote": teacherNote,
        "isCancellationRequested": isCancellationRequested
      };
}
