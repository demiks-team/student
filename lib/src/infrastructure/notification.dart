import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared/helpers/navigation_service/navigation_service.dart';

class NotificationService {
  dynamic currentContext;

  NotificationService() {
    currentContext = NavigationService.navigatorKey.currentContext!;
  }

  void showSuccess(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(currentContext).showSnackBar(snackBar);
  }

  void showMessage(String message, String action) {
    var snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: action,
        onPressed: () {},
      ),
      duration: Duration(microseconds: 5000),
    );
    ScaffoldMessenger.of(currentContext).showSnackBar(snackBar);
  }

  void showError(String message) {
    var snackBar = SnackBar(
      content: Text(message,
          style: TextStyle(color: Color.fromARGB(255, 239, 233, 240))),
      action: SnackBarAction(
        label: AppLocalizations.of(currentContext)!.notificationDismiss,
        onPressed: () {},
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(currentContext).showSnackBar(snackBar);
  }
}
