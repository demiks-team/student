import 'package:flutter/material.dart';
import '../../shared/helpers/colors/hex_color.dart';
import '../../shared/secure_storage.dart';
import '../../shared/theme/colors/app_colors.dart';
import '../../site/screens/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignOutDialogWidget extends StatelessWidget {
  const SignOutDialogWidget({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(AppLocalizations.of(context)!.sure),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: HexColor.fromHex(AppColors.accentColor)),
          onPressed: () {
            SecureStorage.removeCurrentUser();
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
          child: Text(AppLocalizations.of(context)!.yes),
        ),
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: HexColor.fromHex(AppColors.primaryColor)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
    );
  }
}
