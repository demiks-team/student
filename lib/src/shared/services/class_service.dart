import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../authentication/helpers/dio/dio_api.dart';
import '../models/class_model.dart';

class ClassService {
  Future<List<ClassModel>> getClasses() async {
    var response =
        await DioApi().dio.get(dotenv.env['api'].toString() + "groups/list");

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));
      var classList = decodedList["data"] as List;

      List<ClassModel> classes = classList
          .map(
            (dynamic item) => ClassModel.fromJson(item),
          )
          .toList();
      return classes;
    } else {
      throw "Unable to retrieve classes.";
    }
  }

  Future<ClassModel> getClass(int id) async {
    var response = await DioApi()
        .dio
        .get(dotenv.env['api'].toString() + "groups/group/" + id.toString());

    Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));

    if (response.statusCode == 200) {
      return ClassModel.fromJson(decodedList);
    } else {
      throw Exception('Unable to retrieve class.');
    }
  }
}
