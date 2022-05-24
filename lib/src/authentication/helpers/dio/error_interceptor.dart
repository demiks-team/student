import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student/src/infrastructure/notification.dart';
import 'package:student/src/shared/helpers/navigation_service/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/helpers/navigation_service/navigation_service.dart';
import '../../../shared/secure_storage.dart';
import '../../../site/screens/login_screen.dart';
import '../../services/authentication_service.dart';

// reference : https://medium.com/dreamwod-tech/flutter-dio-framework-best-practices-668985fc75b7

class ErrorsInterceptor extends Interceptor {
  final Dio dio;
  dynamic currentContext;
  NotificationService notificationService = NotificationService();
  final authService = AuthenticationService();

  ErrorsInterceptor(this.dio) {
    currentContext = NavigationService.navigatorKey.currentContext!;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      //   throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            Map<dynamic, dynamic>? decodedList;
            try {
              decodedList = jsonDecode(json.encode(err.response?.data));
            } catch (e) {
              decodedList = null;
            }
            if (decodedList != null) {
              var errorCode = decodedList["code"] as String;
              switch (errorCode) {
                case 'authFailed':
                  notificationService.showError(
                      AppLocalizations.of(currentContext)!.authFailed);
                  break;
                case 'passwordComplexity':
                  notificationService.showError(
                      AppLocalizations.of(currentContext)!.passwordComplexity);
                  break;
                default:
                  notificationService.showError(
                      AppLocalizations.of(currentContext)!.generalError);
              }
            } else {
              notificationService.showError(err.response?.data);
            }
            return handler.next(BadRequestException(err.requestOptions));
          case 401:
            var user = await SecureStorage.getCurrentUser();
            SecureStorage.removeCurrentUser();
            if (user != null) {
              await authService.refreshToken(user.refresh!);

              final opts = Options(
                  method: err.requestOptions.method,
                  headers: err.requestOptions.headers);
              final cloneReq = await dio.request(err.requestOptions.path,
                  options: opts,
                  data: err.requestOptions.data,
                  queryParameters: err.requestOptions.queryParameters);
              return handler.resolve(cloneReq);
            } else {
              Navigator.of(currentContext, rootNavigator: true)
                  .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
              return handler.next(UnauthorizedException(err.requestOptions));
            }
          // case 404:
          //   throw NotFoundException(err.requestOptions);
          // case 409:
          //   throw ConflictException(err.requestOptions);
          case 500:
            notificationService
                .showError(AppLocalizations.of(currentContext)!.generalError);
            return handler
                .next(InternalServerErrorException(err.requestOptions));
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

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}
