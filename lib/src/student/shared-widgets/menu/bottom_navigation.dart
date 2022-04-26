import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student/src/shared/theme/colors/demiks_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/helpers/navigation_service/navigation_service.dart';
import '../../../shared/helpers/colors/hex_color.dart';
import '../../screens/group/group_list_screen.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/invoice/invoice_screen.dart';
import '../confirmation.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _tabs = <Widget>[
    DashboardScreen(),
    GroupListScreen(),
    InvoiceScreen(),
    ConfirmationWidget(
        title:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .signOut),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: HexColor.fromHex('#fafafa'),
            activeColor: HexColor.fromHex(DemiksColors.accentColor),
            inactiveColor: HexColor.fromHex(DemiksColors.backgroundColorGray),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.dashboard),
                label: AppLocalizations.of(context)!.dashboard,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.group),
                label: AppLocalizations.of(context)!.classes,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.receipt),
                label: AppLocalizations.of(context)!.invoices,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.logout),
                label: AppLocalizations.of(context)!.signOut,
              ),
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return _tabs[index];
              },
            );
          }),
    );
  }
}
