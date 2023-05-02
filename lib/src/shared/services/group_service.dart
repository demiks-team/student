import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student/src/shared/models/group_student_model.dart';

import '../../authentication/helpers/dio/dio_api.dart';
import '../models/course_material_model.dart';
import '../models/evaluation_criteria_group_student_model.dart';
import '../models/group_file_model.dart';
import '../models/group_learning_material_model.dart';
import '../models/group_model.dart';
import '../models/homework_model.dart';
import '../models/quiz_grade_model.dart';

class GroupService {
  Future<List<GroupModel>> getGroups() async {
    var response =
        await DioApi().dio.get(dotenv.env['api'].toString() + "groups/list");

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));
      var classList = decodedList["data"] as List;

      List<GroupModel> groups = classList
          .map(
            (dynamic item) => GroupModel.fromJson(item),
          )
          .toList();
      return groups;
    } else {
      throw "Unable to retrieve groups.";
    }
  }

  Future<GroupModel> getGroup(int id) async {
    var response = await DioApi()
        .dio
        .get(dotenv.env['api'].toString() + "groups/group/" + id.toString());

    Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));

    if (response.statusCode == 200) {
      return GroupModel.fromJson(decodedList);
    } else {
      throw Exception('Unable to retrieve class.');
    }
  }

  Future<List<CourseMaterialModel>> getGroupCourseMaterials(
      int groupId, int sessionNumber) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        "groups/group/" +
        groupId.toString() +
        "/session/" +
        sessionNumber.toString() +
        "/courseMaterials");

    if (response.statusCode == 200) {
      List decodedList = jsonDecode(json.encode(response.data));

      List<CourseMaterialModel> courseLearningMaterials = decodedList
          .map(
            (dynamic item) => CourseMaterialModel.fromJson(item),
          )
          .toList();

      return courseLearningMaterials;
    } else {
      throw Exception('Unable to retrieve group.');
    }
  }

  Future<GroupStudentModel> getStudentAttendances(int groupId) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        "groups/group/" +
        groupId.toString() +
        "/studentattendance");

    Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));

    if (response.statusCode == 200) {
      return GroupStudentModel.fromJson(decodedList);
    } else {
      throw "Unable to retrieve group student model.";
    }
  }

  Future<List<GroupFileModel>> getGroupLearningMaterialFiles(int id) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        "groups/group/" +
        id.toString() +
        "/files");

    if (response.statusCode == 200) {
      List decodedList = jsonDecode(json.encode(response.data));

      List<GroupFileModel> groupLearningMaterials = decodedList
          .map(
            (dynamic item) => GroupFileModel.fromJson(item),
          )
          .toList();

      return groupLearningMaterials;
    } else {
      throw Exception('Unable to retrieve group.');
    }
  }

  Future<void> getFileFromGroupLearningMaterial(
      String fileName, String guid) async {
    var dir = await getApplicationDocumentsDirectory();

    var response = await DioApi().dio.download(
        dotenv.env['api'].toString() +
            "groups/file/" +
            fileName +
            "/" +
            guid +
            "/download",
        dir);

    if (response.statusCode != 200) {
      throw Exception('Unable to retrieve file.');
    }
  }

  Future<List<QuizGradeModel>> getQuizzes(int groupId) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        "groups/group/" +
        groupId.toString() +
        "/quizzes");

    if (response.statusCode == 200) {
      List decodedList = jsonDecode(json.encode(response.data));

      List<QuizGradeModel> quizGradeModel = decodedList
          .map(
            (dynamic item) => QuizGradeModel.fromJson(item),
          )
          .toList();

      return quizGradeModel;
    } else {
      throw "Unable to retrieve quizzes.";
    }
  }

  Future<List<HomeworkModel>> getHomeworks(
      int groupId, int sessionNumber) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        "groups/group/" +
        groupId.toString() +
        "/session/" +
        sessionNumber.toString() +
        "/homeworks");

    if (response.statusCode == 200) {
      List decodedList = jsonDecode(json.encode(response.data));

      List<HomeworkModel> homeworkList = decodedList
          .map(
            (dynamic item) => HomeworkModel.fromJson(item),
          )
          .toList();

      return homeworkList;
    } else {
      throw "Unable to retrieve homeworks.";
    }
  }

  Future<EvaluationCriteriaGroupStudentModel> getEvaluationCriteria(
      int id) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        "groups/group/" +
        id.toString() +
        "/evaluationcriteria");

    Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));

    if (response.statusCode == 200) {
      return EvaluationCriteriaGroupStudentModel.fromJson(decodedList);
    } else {
      throw Exception('Unable to retrieve class.');
    }
  }

  Future<void> getCertificateStudent(int groupId) async {
    var dir = await getApplicationDocumentsDirectory();

    var response = await DioApi().dio.download(
        dotenv.env['api'].toString() +
            "certificate/export/" +
            groupId.toString(),
        dir);

    if (response.statusCode != 200) {
      throw Exception('Unable to retrieve file.');
    }
  }

  Future<void> exportReportCardStudent(int groupId) async {
    var dir = await getApplicationDocumentsDirectory();

    var response = await DioApi().dio.download(
        dotenv.env['api'].toString() +
            "groups/group/" +
            groupId.toString() +
            "/exportreportcard",
        dir);

    if (response.statusCode != 200) {
      throw Exception('Unable to retrieve file.');
    }
  }
}
