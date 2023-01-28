import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nusketch/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // initializing firebase when app runs
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // uses GetMaterialApp instead of MaterialApp so Getx package can get screen dimensions
      debugShowCheckedModeBanner: false,
      title: 'Nusketch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const Loading(), // sets the mainpage to widget named MainPage which is in heading.dart
    );
  }
}
