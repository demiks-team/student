import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student/src/shared/services/general_service.dart';
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
  final GeneralService generalService = GeneralService();
  bool invoiceAllow = false;
  bool groupAllow = false;
  bool loading = true;

  @override
  void initState() {
    getSchoolFeatures();
    super.initState();
  }

  Future<void> getSchoolFeatures() async {
    var response = await generalService.getFeatures();
    setState(() {
      for (var item in response) {
        if (item.features != null) {
          var hasInvoice = item.features!.any((s) => s.contains("invoicing"));
          if (hasInvoice) {
            invoiceAllow = true;
          }
          var hasGroup = item.features!.any((s) => s.contains("classes"));
          if (hasGroup) {
            groupAllow = true;
          }
        }
      }
      if (!groupAllow && !invoiceAllow) {
        tabs.removeAt(1);
        tabs.removeAt(1);
      } else {
        if (!groupAllow) {
          tabs.removeAt(1);
        }
        if (!invoiceAllow) {
          tabs.removeAt(2);
        }
      }
      loading = false;
    });
  }

  List<Widget> tabs = <Widget>[
    const DashboardScreen(),
    const GroupListScreen(),
    const InvoiceListScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (!loading) {
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
                if (groupAllow)
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.group),
                    label: AppLocalizations.of(context)!.classes,
                  ),
                if (invoiceAllow)
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
                  return tabs[index];
                },
              );
            }),
      );
    } else {
      return Container(color: Colors.white);
    }
  }
}
