import 'dart:convert';

import 'evaluation_criteria_group_model.dart';
import 'group_enrollment_model.dart';

List<EvaluationCriteriaGroupStudentModel> groupFromJson(String str) =>
    List<EvaluationCriteriaGroupStudentModel>.from(json
        .decode(str)
        .map((x) => EvaluationCriteriaGroupStudentModel.fromJson(x)));
String groupToJson(List<EvaluationCriteriaGroupStudentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EvaluationCriteriaGroupStudentModel {
  EvaluationCriteriaGroupStudentModel({
    required this.id,
    this.fullName,
    this.groupEnrollmentId,
    this.groupEnrollment,
    this.evaluationCriteriaGroup,
  });
  int id;
  String? fullName;
  int? groupEnrollmentId;
  GroupEnrollmentModel? groupEnrollment;
  List<EvaluationCriteriaGroupModel>? evaluationCriteriaGroup;
  factory EvaluationCriteriaGroupStudentModel.fromJson(
          Map<String, dynamic> json) =>
      EvaluationCriteriaGroupStudentModel(
        id: json["id"],
        fullName: json["fullName"],
        groupEnrollmentId: json["groupEnrollmentId"],
        groupEnrollment: json["groupEnrollment"] != null
            ? GroupEnrollmentModel.fromJson(json["groupEnrollment"])
            : null,
        evaluationCriteriaGroup: json["evaluationCriteriaGroup"] != null
            ? (json["evaluationCriteriaGroup"] as List)
                .map(
                  (dynamic item) => EvaluationCriteriaGroupModel.fromJson(item),
                )
                .toList()
            : null,
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "groupEnrollmentId": groupEnrollmentId,
        "groupEnrollment":
            groupEnrollment != null ? groupEnrollment!.toJson() : null,
        if (evaluationCriteriaGroup != null)
          "evaluationCriteriaGroup": evaluationCriteriaGroup
        else
          "evaluationCriteriaGroup": null,            
      };
}
