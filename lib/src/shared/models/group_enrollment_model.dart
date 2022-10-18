import 'dart:convert';


List<GroupEnrollmentModel> groupFromJson(String str) =>
    List<GroupEnrollmentModel>.from(json.decode(str).map((x) => GroupEnrollmentModel.fromJson(x)));
String groupToJson(List<GroupEnrollmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupEnrollmentModel {
  GroupEnrollmentModel({
    required this.id,
    this.groupId,
    this.startDate,
    this.endDate,
    this.groupEnrollmentStatus,
    this.canStudentPrintCertificate,
    this.canStudentPrintReportCard,
  });
  int id;
  int? groupId;
  String? startDate;
  String? endDate;
  int? groupEnrollmentStatus;
  bool? canStudentPrintCertificate;
  bool? canStudentPrintReportCard;
  factory GroupEnrollmentModel.fromJson(Map<String, dynamic> json) => GroupEnrollmentModel(
        id: json["id"],
        groupId: json["groupId"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        groupEnrollmentStatus: json["groupEnrollmentStatus"],
        canStudentPrintCertificate: json["canStudentPrintCertificate"],
        canStudentPrintReportCard: json["canStudentPrintReportCard"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "groupId": groupId,
        "startDate": startDate,
        "endDate": endDate,
        "groupEnrollmentStatus": groupEnrollmentStatus,
        "canStudentPrintCertificate": canStudentPrintCertificate,
        "canStudentPrintReportCard": canStudentPrintReportCard,
      };
}