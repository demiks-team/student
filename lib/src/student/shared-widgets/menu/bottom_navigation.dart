import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student/src/shared/theme/colors/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/helpers/colors/hex_color.dart';
import '../../screens/group/group_list_screen.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/invoice/invoice_list_screen.dart';
import '../../screens/more/more_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _tabs = const <Widget>[
    DashboardScreen(),
    GroupListScreen(),
    InvoiceListScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: HexColor.fromHex('#fafafa'),
            activeColor: HexColor.fromHex(AppColors.accentColor),
            inactiveColor: HexColor.fromHex(AppColors.backgroundColorGray),
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
                icon: const Icon(Icons.widgets),
                label: AppLocalizations.of(context)!.more,
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
