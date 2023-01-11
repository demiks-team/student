import 'dart:convert';

import 'package:student/src/shared/models/course_model.dart';

import 'course_material_page_model.dart';

List<CourseMaterialModel> invoiceFromJson(String str) =>
    List<CourseMaterialModel>.from(
        json.decode(str).map((x) => CourseMaterialModel.fromJson(x)));
String invoiceToJson(List<CourseMaterialModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseMaterialModel {
  CourseMaterialModel(
      {required this.id,
      this.programId,
      this.program,
      this.schoolId,
      this.teacherUserId,
      this.createdOn,
      this.title,
      this.sessionNumber,
      this.isAvailableToTeacher,
      this.isAvailableToStudents,
      this.courseMaterialPages});
  int id;
  int? programId;
  CourseModel? program;
  int? schoolId;
  int? teacherUserId;
  String? createdOn;
  String? title;
  int? sessionNumber;
  bool? isAvailableToTeacher;
  bool? isAvailableToStudents;
  List<CourseMaterialPageModel>? courseMaterialPages;
  factory CourseMaterialModel.fromJson(Map<String, dynamic> json) =>
      CourseMaterialModel(
        id: json["id"],
        programId: json["programId"],
        program: json["program"] != null
            ? CourseModel.fromJson(json["program"])
            : null,
        schoolId: json["schoolId"],
        teacherUserId: json["teacherUserId"],
        createdOn: json["createdOn"],
        title: json["title"],
        sessionNumber: json["sessionNumber"],
        isAvailableToTeacher: json["isAvailableToTeacher"],
        isAvailableToStudents: json["isAvailableToStudents"],
        courseMaterialPages: json["courseMaterialPages"] != null
            ? (json["courseMaterialPages"] as List)
                .map(
                  (dynamic item) => CourseMaterialPageModel.fromJson(item),
                )
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "programId": programId,
        "program": program != null ? program!.toJson() : null,
        "schoolId": schoolId,
        "teacherUserId": teacherUserId,
        "createdOn": createdOn,
        "title": title,
        "sessionNumber": sessionNumber,
        "isAvailableToTeacher": isAvailableToTeacher,
        "isAvailableToStudents": isAvailableToStudents,
        if (courseMaterialPages != null)
          "courseMaterialPages": courseMaterialPages
        else
          "courseMaterialPages": null,
      };
}
