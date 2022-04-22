import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student/src/shared/helpers/navigation_service/navigation_service.dart';

import '../../../shared/helpers/navigation_service/navigation_service.dart';
import '../../../shared/secure_storage.dart';
import '../../../site/screens/login_screen.dart';

// reference : https://medium.com/dreamwod-tech/flutter-dio-framework-best-practices-668985fc75b7

class ErrorsInterceptor extends Interceptor {
  final Dio dio;
  dynamic currentContext;

  ErrorsInterceptor(this.dio) {
    currentContext = NavigationService.navigatorKey.currentContext!;
  }

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
            SecureStorage.removeCurrentUser();
            Navigator.of(currentContext, rootNavigator: true)
                .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
            print('error 401 works!');
            print('error 401 works! again');
            throw UnauthorizedException(err.requestOptions);
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

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}
