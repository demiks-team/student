import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared-widgets/sign_out_dialog_widget.dart';
import 'widgets/about_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.more),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: <Widget>[
            ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AboutScreen()));
                },
                title: Text(AppLocalizations.of(context)!.about),
                minLeadingWidth: 10,
                leading: const Icon(Icons.store)),
            const Divider(),
            ListTile(
                onTap: () async {
                  if (!await launchUrl(Uri.parse('https://www.demiks.com/docs/student'))) {
                    throw 'Could not launch url';
                  }
                },
                title: Text(AppLocalizations.of(context)!.help),
                minLeadingWidth: 10,
                leading: const Icon(Icons.help)),
            const Divider(),
            ListTile(
                onTap: () async {
                  if (!await launchUrl(
                      Uri.parse('https://demiks.com/contact'))) {
                    throw 'Could not launch url';
                  }
                },
                title: Text(AppLocalizations.of(context)!.contact),
                minLeadingWidth: 10,
                leading: const Icon(Icons.support)),
            const Divider(),
            ListTile(
                onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SignOutDialogWidget(
                            title: AppLocalizations.of(context)!.signOut);
                      },
                    ),
                title: Text(AppLocalizations.of(context)!.signOut),
                minLeadingWidth: 10,
                leading: const Icon(Icons.logout)),
            const Divider(),
          ],
        )
        // )
        );
  }
}
