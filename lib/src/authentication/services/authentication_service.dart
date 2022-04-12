import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class AuthenticationService {
  Future<Object> login(String email, String password) async {
    var response = await post(Uri.parse((dotenv.env['api']).toString() + "security/login"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unable to login user.');
    }
  }
}
