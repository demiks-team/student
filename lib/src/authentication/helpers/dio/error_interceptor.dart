import 'package:dio/dio.dart';

class ErrorsInterceptor extends Interceptor {
  final Dio dio;

  ErrorsInterceptor(this.dio);


  // reference : https://medium.com/dreamwod-tech/flutter-dio-framework-best-practices-668985fc75b7

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      //   throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          // case 400:
          //   throw BadRequestException(err.requestOptions);
          case 401:
            print('error 401 works!');
            print('error 401 works! again');
            
          // throw UnauthorizedException(err.requestOptions);
          // case 404:
          //   throw NotFoundException(err.requestOptions);
          // case 409:
          //   throw ConflictException(err.requestOptions);
          // case 500:
          //   throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        print('Other workssss');
      // throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}
