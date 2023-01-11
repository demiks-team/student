import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../authentication/helpers/dio/dio_api.dart';
import '../models/course_material_model.dart';

class CourseMaterialService {
  Future<CourseMaterialModel> getCourseMaterial(int id) async {
    var response = await DioApi()
        .dio
        .get(dotenv.env['api'].toString() + "courseMaterial/" + id.toString());

    Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));

    if (response.statusCode == 200) {
      return CourseMaterialModel.fromJson(decodedList);
    } else {
      throw Exception('Unable to retrieve course material.');
    }
  }
}
