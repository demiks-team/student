import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../helpers/dio/dio_api.dart';

class AuthenticationService {
  Future<String?> login(String email, String password) async {
    var response = await DioApi().dio.post(
          dotenv.env['api'].toString() + "security/login",
          data: json.encode({"email": email, "password": password}),
        );
    return json.encode(response.data).toString();

    // if (response.statusCode == 200) {
    //   return json.encode(response.data).toString();
    // } else {
    //   throw Exception('Unable to login user.');
    // }
  }
}
