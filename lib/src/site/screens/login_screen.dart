import 'package:flutter/material.dart';
import '../../student/shared-widgets/menu/bottom_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email as example@email.com'),
                )),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                child: Text('Login'),
                style: ElevatedButton.styleFrom(primary: Color(0xFFf89a1f)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => BottomNavigation()));
                },
              ),
            ),
          ],
        )));
  }
}
