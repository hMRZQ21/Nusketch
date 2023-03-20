import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nusketch/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nusketch/pages/camera.dart';
import 'package:nusketch/pages/convertingloading.dart';
import 'firebase_options.dart';
import 'package:ffi/ffi.dart';
import 'package:nusketch/pages/mainpage.dart';

Future<void> main() async {
  // initializing firebase when app runs
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  // final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  // final firstCamera = cameras.first;

  runApp(
    MaterialApp(home: MainPage()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusketch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Loading(),
    );
  }
}
