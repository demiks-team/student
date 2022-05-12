import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'shared/helpers/colors/hex_color.dart';
import 'shared/helpers/colors/material_color.dart';
import 'shared/helpers/navigation_service/navigation_service.dart';
import 'shared/secure_storage.dart';
import 'shared/theme/colors/demiks_colors.dart';
import 'site/screens/login_screen.dart';
import 'student/shared-widgets/menu/bottom_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool? isUserLoggedIn;

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    var currentUser = await SecureStorage.getCurrentUser();
    if (currentUser != null) {
      setState(() {
        isUserLoggedIn = true;
      });
    } else {
      setState(() {
        isUserLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demiks Student App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
        Locale('fr', ''),
      ],
      theme:
          ThemeData(primarySwatch: buildMaterialColor(const Color(0xffffffff))),
      home: isUserLoggedIn == null
          ? Center(
              child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: HexColor.fromHex(DemiksColors.accentColor)))
          : isUserLoggedIn!
              ? const BottomNavigation()
              : const LoginScreen(),
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
