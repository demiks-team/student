import 'dart:convert';

import 'course_model.dart';
import 'room_model.dart';
import 'school_model.dart';
import 'teacher_model.dart';

List<GroupModel> groupFromJson(String str) =>
    List<GroupModel>.from(json.decode(str).map((x) => GroupModel.fromJson(x)));
String groupToJson(List<GroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupModel {
  GroupModel({
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
    this.numberOfSessions,
    this.evaluationIsDone
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
  int? numberOfSessions;
  bool? evaluationIsDone;
  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
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
        numberOfSessions: json["numberOfSessions"],
        evaluationIsDone: json["evaluationIsDone"]
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
        "numberOfSessions": numberOfSessions,
        "evaluationIsDone": evaluationIsDone
      };
}
