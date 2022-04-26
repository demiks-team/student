import 'dart:convert';

import 'package:student/src/shared/models/session_summary_model.dart';

List<GroupStudentModel> groupStudentFromJson(String str) =>
    List<GroupStudentModel>.from(
        json.decode(str).map((x) => GroupStudentModel.fromJson(x)));
String groupStudentToJson(List<GroupStudentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupStudentModel {
  GroupStudentModel({
    required this.id,
    this.fullName,
    this.sessions,
  });
  int id;
  String? fullName;
  List<SessionSummaryModel>? sessions;
  factory GroupStudentModel.fromJson(Map<String, dynamic> json) =>
      GroupStudentModel(
          id: json["id"],
          fullName: json["fullName"],
          sessions: json["sessions"] != null
              ? (json["sessions"] as List)
                  .map(
                    (dynamic item) => SessionSummaryModel.fromJson(item),
                  )
                  .toList()
              : null);
  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "sessions": sessions,
      };
}
