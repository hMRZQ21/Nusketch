import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nusketch/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  // initializing firebase when app runs
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}


class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      // uses GetMaterialApp instead of MaterialApp so Getx package can get screen dimensions
      debugShowCheckedModeBanner: false,
      title: 'Nusketch',
      home:
      Loading(), // sets the mainpage to widget named MainPage which is in heading.dart
    );
}
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       // uses GetMaterialApp instead of MaterialApp so Getx package can get screen dimensions
//       debugShowCheckedModeBanner: false,
//       title: 'Nusketch',
//       theme: lightTheme,//ThemeData.light(),
//       darkTheme: darkTheme,//ThemeData.dark(),
//       themeMode: _themeManager.themeMode(),
//       home:
//           const Loading(), // sets the mainpage to widget named MainPage which is in heading.dart
//     );
//   }


}
