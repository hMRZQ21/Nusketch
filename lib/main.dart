import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nusketch/pages/artpage.dart';


Future<void> main() async {
  // initializing firebase when app runs
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Obtain a list of the available cameras on the device.
  // final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  // final firstCamera = cameras.first;

  runApp(MyApp() // MaterialApp(home: MainPage()),
      );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color pickerColor = const Color(0xff443a49);
    final ValueNotifier<Color> selectedColor = ValueNotifier<Color>(pickerColor);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusketch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArtPage(selectedColor), //Page(),
      //If you dont want to wait for the loading screen change this ^ not the function on top.
    );
  }
}
