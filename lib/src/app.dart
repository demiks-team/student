import 'package:flutter/material.dart';

import 'shared/helpers.dart';
import 'site/screens/login_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: ThemeData(primarySwatch: buildMaterialColor(const Color(0xffffffff))),
      home: LoginScreen(),
    );
  }
}
