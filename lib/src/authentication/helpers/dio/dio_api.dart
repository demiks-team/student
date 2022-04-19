import 'package:dio/dio.dart';
import 'error_interceptor.dart';
import 'jwt_interceptor.dart';

class DioApi {
  final dio = createDio();
  // final tokenDio = Dio(BaseOptions(baseUrl: Globals().Url));
  
  // reference : https://medium.com/dreamwod-tech/flutter-dio-framework-best-practices-668985fc75b7

  DioApi._internal();

  static final _singleton = DioApi._internal();

  factory DioApi() => _singleton;

  static Dio createDio() {
    // BaseOptions baseOptions = BaseOptions(
    //   headers: {}
    // );

    final dio = Dio();

    dio.interceptors.addAll({
      JwtInterceptor(dio),
      ErrorsInterceptor(dio),
    });
    return dio;
  }
}
