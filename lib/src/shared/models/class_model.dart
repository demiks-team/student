import 'dart:convert';

import 'course_model.dart';
import 'room_model.dart';
import 'school_model.dart';
import 'teacher_model.dart';

List<ClassModel> userFromJson(String str) =>
    List<ClassModel>.from(json.decode(str).map((x) => ClassModel.fromJson(x)));
String userToJson(List<ClassModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassModel {
  ClassModel({
    required this.id,
    this.title,
    this.schoolId,
    this.school,
    this.teacherId,
    this.teacher,
    this.courseId,
    this.course,
    this.roomId,
    this.room,
  });
  int id;
  String? title;
  int? schoolId;
  SchoolModel? school;
  int? teacherId;
  TeacherModel? teacher;
  int? courseId;
  CourseModel? course;
  int? roomId;
  RoomModel? room;
  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        id: json["id"],
        title: json["title"],
        schoolId: json["schoolId"],
        school: json["school"] != null
            ? SchoolModel.fromJson(json["school"])
            : null,
        teacherId: json["teacherId"],
        teacher: json["teacher"] != null
            ? TeacherModel.fromJson(json["teacher"])
            : null,
        courseId: json["programId"],
        course: json["program"] != null
            ? CourseModel.fromJson(json["program"])
            : null,
        roomId: json["roomId"],
        room: json["room"] != null ? RoomModel.fromJson(json["room"]) : null,
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "schoolId": schoolId,
        "school": school != null ? school!.toJson() : null,
        "teacherId": teacherId,
        "teacher": teacher != null ? teacher!.toJson() : null,
        "programId": courseId,
        "program": course != null ? course!.toJson() : null,
        "roomId": roomId,
        "room": room != null ? room!.toJson() : null,
      };
}
