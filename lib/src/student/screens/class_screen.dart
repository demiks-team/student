import 'package:flutter/material.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Classes'),
          automaticallyImplyLeading: false,
        ),
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
                padding: const EdgeInsets.only(top: 60.0),
                child: Text('Class Screen'),
              )
            ],
          ),
        ));
  }
}
