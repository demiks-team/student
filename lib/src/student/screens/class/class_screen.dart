import 'package:flutter/material.dart';
import 'package:student/src/student/widgets/class/class_list.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Classes'),
          automaticallyImplyLeading: false,
        ),
        body: ClassList()
        // body: SingleChildScrollView(
        // child: Column(
        //   children: <Widget>[
        //     Padding(
        //         padding: const EdgeInsets.only(top: 60.0),
        //         child: Center(
        //           child: Container(
        //               width: 300,
        //               height: 50,
        //               child: Image.asset('assets/images/logo.png')),
        //         )),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 60.0),
        //       child: ClassList(),
        //     ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 60.0),
        //   child: Text('Class Screen'),
        // )
        // ],
        // ),
        );
  }
}
