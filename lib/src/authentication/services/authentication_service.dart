import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthenticationService {
  final dio = Dio();

  Future<String?> login(String email, String password) async {
    var response = await dio.post(
      dotenv.env['api'].toString() + "security/login",
      data: json.encode({"email": email, "password": password}),
    );
    
    if (response.statusCode == 200) {
      return json.encode(response.data).toString();
    } else {
      throw Exception('Unable to login user.');
    }
  }
}
