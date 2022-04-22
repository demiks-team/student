import 'package:flutter/material.dart';
import '../../shared/secure_storage.dart';
import '../../site/screens/login_screen.dart';
import 'menu/bottom_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(primary: Colors.green),
          onPressed: () {
            SecureStorage.removeCurrentUser();
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
          child: const Text('Yes'),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Colors.purple),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (_) => const BottomNavigation()));
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
