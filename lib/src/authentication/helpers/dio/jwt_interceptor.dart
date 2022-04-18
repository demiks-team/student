import 'package:dio/dio.dart';

import '../../../shared/secure_storage.dart';
import '../../models/user_model.dart';

class JwtInterceptor extends Interceptor {
  final Dio dio;
  UserModel? currentUser;

  JwtInterceptor(this.dio);

  getCurrentUser() async {
    currentUser = await SecureStorage.getCurrentUser();
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    await getCurrentUser();
    if (currentUser != null) {
      options.headers['Authorization'] =
          'Bearer ' + currentUser!.token.toString();
    }
    return handler.next(options);
  }
}
