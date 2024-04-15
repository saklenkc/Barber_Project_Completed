import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:updated_barber_project/adminPanel.dart';
import 'package:updated_barber_project/firebase_options.dart';
import 'package:updated_barber_project/pages/onBoarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: onBoarding(),
    );
  }
}
