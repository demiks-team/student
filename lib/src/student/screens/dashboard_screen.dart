import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text('Dashboard Screen'),
          )
        ],
      ),
    ));
  }
}


// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Padding(
//                   padding: const EdgeInsets.only(top: 60.0),
//                   child: Center(
//                     child: Container(
//                         width: 300,
//                         height: 200,
//                         child: Image.asset('assets/images/logo.png')),
//                   )),
//               Padding(
//                 padding: const EdgeInsets.only(top: 60.0),
//                 child: Text('Dashboard Screen'),
//               )
//             ],
//           ),
//         ));
//   }
// }
