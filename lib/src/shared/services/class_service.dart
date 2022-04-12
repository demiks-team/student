import 'dart:convert';
import 'package:http/http.dart';

import '../models/class_model.dart';

class ClassService {
  final String classesURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Class>> getClasses() async {
    Response response = await get(Uri.parse(classesURL));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Class> classes = body
          .map(
            (dynamic item) => Class.fromJson(item),
          )
          .toList();

      return classes;
    } else {
      throw "Unable to retrieve classes.";
    }
  }

  Future<Class> getClass(int id) async {
    Response response = await get(Uri.parse(classesURL + '/$id'));

    if (response.statusCode == 200) {
      return Class.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to retrieve class.');
    }
  }
}
