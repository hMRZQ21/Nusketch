import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/accountsettings.dart';
import 'package:nusketch/pages/camera.dart';
import 'package:nusketch/pages/portfolios.dart';
import 'package:nusketch/pages/uploadpage.dart';

import '../util/dimension.dart';
import 'homepage.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MyPageState();
// }

// class _MyPageState extends State<MainPage> {
//   //This is to keep track of the bottom navigation bar
//   int selectedIndex = 0;
//   void navigateBottomNavBar(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   //This will populate the body for the given page clicked
//   final List<Widget> children = [
//     const HomePage(),
//     const CameraPage(),
//     const UploadPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: children[selectedIndex],
//       bottomNavigationBar: CupertinoTabBar(
//         currentIndex: selectedIndex,
//         onTap: navigateBottomNavBar,
//         // ignore: prefer_const_literals_to_create_immutables
//         items: [
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'home',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.camera_alt_rounded),
//             label: 'camera',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.upload),
//             label: 'upload',
//           ),
//         ],
//       ),
//     );
//   }
// }
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyPageState();
}

class _MyPageState extends State<MainPage> {
  int selectedIndex = 0;
  void navigateBottomNavBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> children = [
    const HomePage(),
    const CameraPage(),
    const UploadPage(),
    const AccountSettings(),
    const PortfoliosPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: children[selectedIndex],
      bottomNavigationBar: Container(
        height: Dimension.page60h,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home,
                    color: Colors.blue.shade400, size: Dimension.size35),
                onPressed: () => navigateBottomNavBar(0),
              ),
              IconButton(
                icon: Icon(Icons.upload,
                    color: Colors.blue.shade400, size: Dimension.size35),
                onPressed: () => navigateBottomNavBar(2),
              ),
              IconButton(
                icon: Icon(Icons.folder,
                    color: Colors.blue.shade400, size: Dimension.size35),
                onPressed: () => navigateBottomNavBar(4),
              ),
              IconButton(
                icon: Icon(Icons.account_circle,
                    color: Colors.blue.shade400, size: Dimension.size35),
                onPressed: () => navigateBottomNavBar(3),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => navigateBottomNavBar(1),
        child: Icon(CupertinoIcons.camera_fill,
            color: Colors.blue.shade800, size: Dimension.size31),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
    );
  }
}
