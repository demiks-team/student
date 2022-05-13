import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/helpers/colors/hex_color.dart';
import '../../../../shared/theme/colors/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.about),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: HexColor.fromHex(AppColors.accentColor)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Center(
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 2, right: 2, bottom: 5, top: 25),
                    width: 180,
                    height: 80,
                    child: Image.asset('assets/images/logo.png')),
              )),
          Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              AppLocalizations.of(context)!.aboutTitle,
              style: const TextStyle(fontSize: 18, height: 1.5),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              AppLocalizations.of(context)!.aboutDescription,
              style: const TextStyle(fontSize: 18, height: 1.5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 5, bottom: 15),
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.learnMoreAboutUs,
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 18),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (!await launchUrl(
                                  Uri.parse('https://www.demiks.com/about'))) {
                                throw 'Could not launch url';
                              }
                            },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 5, bottom: 65),
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.contactUs,
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 18),
                          recognizer: TapGestureRecognizer()..onTap = () async {
                              if (!await launchUrl(
                                  Uri.parse('https://www.demiks.com/contact'))) {
                                throw 'Could not launch url';
                              }
                            },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ])));
  }
}
