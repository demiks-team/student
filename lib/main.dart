import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/app.dart';

Future<void> main() async {
  if (kReleaseMode) {
    await dotenv.load(fileName: "environments/.env.production");
  } else {
    await dotenv.load(fileName: "environments/.env.development");
  }


  runApp(const App());
}
