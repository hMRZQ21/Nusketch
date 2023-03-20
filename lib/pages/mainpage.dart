import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:nusketch/pages/accountsettings.dart';
import 'package:nusketch/pages/camera.dart';
import 'package:nusketch/pages/folders.dart';
import 'package:nusketch/pages/uploadpage.dart';
import '../util/dimension.dart';
import 'homepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyPageState();
}

class _MyPageState extends State<MainPage> {
  late CameraDescription _camera;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    setState(() {
      _camera = cameras.first;
    });
  }

  int selectedIndex = 0;
  void navigateBottomNavBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> children = [
    const HomePage(),
    const UploadPage(),
    // TakePictureScreen(camera: _camera),
    const PortfoliosPage(),
    const AccountSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    if (_camera == null) {
      // Show a loading indicator while the camera is being initialized.
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        // extendBody: true,
        resizeToAvoidBottomInset:
            false, //used to avoid FAB from moving when clicking on something
        body: Center(
          child: IndexedStack(
              index: selectedIndex,
              children:
                  children), //children.elementAt(selectedIndex), //indexedstack saves state of all widgets
        ),
        bottomNavigationBar: SizedBox(
          // height: MediaQuery.of(context).size.height * 0.08,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.orange.shade400,
            unselectedItemColor: Colors.blue.shade600,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.upload),
                label: "upload",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.folder),
                label: "folder",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "profile",
              ),
            ],
            currentIndex: selectedIndex,
            onTap: navigateBottomNavBar,
          ),
        ),

        floatingActionButton: Container(
          height: MediaQuery.of(context).size.height * 0.065,
          width: MediaQuery.of(context).size.width * 0.07,
          child: FittedBox(
            fit: BoxFit.cover,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TakePictureScreen(camera: _camera)),
                )
              },
              child: Icon(
                CupertinoIcons.camera_fill,
                color: Colors.blue.shade800,
                size: 30,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }
}
