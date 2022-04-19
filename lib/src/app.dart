import 'package:flutter/material.dart';
import 'shared/helpers/hex_color.dart';
import 'shared/helpers/material_color.dart';
import 'shared/helpers/navigation_service/navigation_service.dart';
import 'shared/secure_storage.dart';
import 'shared/theme/colors/demiks_colors.dart';
import 'site/screens/login_screen.dart';
import 'student/shared-widgets/menu/bottom_navigation.dart';

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
      theme:
          ThemeData(primarySwatch: buildMaterialColor(const Color(0xffffffff))),
      home: isUserLoggedIn == null
          ? Center(
              child: CircularProgressIndicator(
                  color: HexColor.fromHex(DemiksColors.accentColor)))
          : isUserLoggedIn!
              ? const BottomNavigation()
              : const LoginScreen(),
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
