import 'package:flutter/material.dart';
import '../../shared/helpers/colors/hex_color.dart';
import '../../shared/secure_storage.dart';
import '../../shared/theme/colors/demiks_colors.dart';
import '../../site/screens/login_screen.dart';
import 'menu/bottom_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmationWidget extends StatelessWidget {
  const ConfirmationWidget({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(AppLocalizations.of(context)!.sure),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
              // primary: Colors.green,
              backgroundColor: HexColor.fromHex(DemiksColors.accentColor)),
          onPressed: () {
            SecureStorage.removeCurrentUser();
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
          child: Text(AppLocalizations.of(context)!.yes),
        ),
        TextButton(
          style: TextButton.styleFrom(
              //primary: Colors.purple
              backgroundColor: HexColor.fromHex(DemiksColors.primaryColor)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (_) => const BottomNavigation()));
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
    );
  }
}
