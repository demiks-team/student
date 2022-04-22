import 'package:flutter/material.dart';
import '../../authentication/models/user_model.dart';
import '../../shared/helpers/hex_color.dart';
import '../../shared/secure_storage.dart';
import '../../shared/theme/colors/demiks_colors.dart';
import '../../student/shared-widgets/menu/bottom_navigation.dart';
import '../../authentication/services/authentication_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authenticationService = AuthenticationService();

  // UserModel? currentUser;

  // @override
  // initState() {
  //   super.initState();
  //   getCurrentUser();
  // }

  // getCurrentUser() async {
  //   currentUser = await SecureStorage.getCurrentUser();
  //   if (currentUser != null) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (_) => const BottomNavigation()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 300,
                      height: 200,
                      child: Image.asset('assets/images/logo.png')),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.email,
                      hintText: AppLocalizations.of(context)!.enterValidEmail),
                )),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.password,
                    hintText: AppLocalizations.of(context)!.enterPassword),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                child: Text(AppLocalizations.of(context)!.login),
                style: ElevatedButton.styleFrom(primary: Color(0xFFf89a1f)),
                onPressed: () async {
                  var username = _emailController.text;
                  var password = _passwordController.text;
                  var response =
                      await authenticationService.login(username, password);
                  if (response != null) {
                    await SecureStorage.setCurrentUser(response);
                    // var result = SecureStorage.getCurrentUser();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BottomNavigation()));
                  }
                },
              ),
            ),
          ],
        )));
  }
}
