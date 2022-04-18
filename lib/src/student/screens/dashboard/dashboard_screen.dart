import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../authentication/models/user_model.dart';
import '../../../shared/helpers/hex_color.dart';
import '../../../shared/secure_storage.dart';
import '../../../shared/theme/colors/demiks_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserModel? currentUser;

  @override
  initState() {
    super.initState();
    fetchCurrentUser();
  }

  fetchCurrentUser() async {
    await SecureStorage.getCurrentUser().then((cu) => setState(() {
          currentUser = cu;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 300,
                      height: 100,
                      child: Image.asset('assets/images/logo.png')),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  'Welcome  ' + currentUser!.fullName.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ));
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: HexColor.fromHex(DemiksColors.accentColor),
        ),
      );
    }
  }
}
