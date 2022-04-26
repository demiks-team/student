import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student/src/shared/models/group_student_model.dart';
import '../../authentication/helpers/dio/dio_api.dart';
import '../models/group_file_model.dart';
import '../models/group_learning_material_model.dart';
import '../models/group_model.dart';

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

  Future<List<GroupLearningMaterialModel>> getGroupLearningMaterial(
      int id) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        "learningMaterials/group/" +
        id.toString());

    if (response.statusCode == 200) {
      List decodedList = jsonDecode(json.encode(response.data));

      List<GroupLearningMaterialModel> groupLearningMaterials = decodedList
          .map(
            (dynamic item) => GroupLearningMaterialModel.fromJson(item),
          )
          .toList();

      return groupLearningMaterials;
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
}
