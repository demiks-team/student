import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class no_data extends StatelessWidget {
  const no_data({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.comment),
        Text(
          AppLocalizations.of(context)!.noData,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Image.asset('assets/images/arrow.jpg')
      ],
    );
  }
}
