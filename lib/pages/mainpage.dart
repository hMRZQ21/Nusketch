import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
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
    const UploadPage(),
    // const CameraPage(),
    const PortfoliosPage(),
    const AccountSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // extendBody: true,
      resizeToAvoidBottomInset: false, //used to avoid FAB from moving when clicking on something
      body: Center(
        child: children.elementAt(selectedIndex),
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
                MaterialPageRoute(builder: (context) => const CameraPage()),
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
      //
      // bottomNavigationBar:
      //   BottomAppBar(
      //     shape: const CircularNotchedRectangle(),
      //     notchMargin: 10,
      //     // elevation: 0,
      //       child: Container(
      //         padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.03,),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           mainAxisSize: MainAxisSize.max,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: <Widget>[
      //              IconButton(
      //                icon: Icon(Icons.home,
      //                  color: Colors.blue.shade400,
      //                  size: 30,
      //                ),
      //                onPressed: () => {
      //                  navigateBottomNavBar(0),
      //                  log("Home button is pressed"),
      //                },
      //              ),
      //             IconButton(
      //               // padding: EdgeInsets.only(right: 50),
      //               icon: Icon(Icons.upload,
      //                   color: Colors.blue.shade400,
      //                   size: 30
      //               ),
      //               onPressed: () => {
      //                 navigateBottomNavBar(1),
      //                 log("Home button is pressed"),
      //               },
      //             ),
      //
      //             SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
      //             IconButton(
      //               // padding: EdgeInsets.only(left: 50),
      //               icon: Icon(Icons.folder,
      //                 color: Colors.blue.shade400,
      //                 size: 30,
      //               ),
      //               onPressed: () => {
      //                 navigateBottomNavBar(3),
      //                 log("Home button is pressed"),
      //               },
      //             ),
      //             IconButton(
      //               icon: Icon(Icons.account_circle,
      //                 color: Colors.blue.shade400,
      //                 size: 30,
      //               ),
      //               onPressed: () => {
      //                 navigateBottomNavBar(4),
      //                 log("Home button is pressed"),
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   mainAxisSize: MainAxisSize.max,
      //   children: <Widget>[
      //     IconButton(
      //      icon: Icon(Icons.home,
      //           color: Colors.blue.shade400,
      //           size: 30,
      //      ),
      //       onPressed: () => navigateBottomNavBar(0),
      //     ),
      //     IconButton(
      //       // padding: EdgeInsets.only(right: 50),
      //       icon: Icon(Icons.upload,
      //           color: Colors.blue.shade400,
      //           size: 30
      //       ),
      //       onPressed: () => navigateBottomNavBar(2),
      //     ),
      //     IconButton(
      //       // padding: EdgeInsets.only(left: 50),
      //       icon: Icon(Icons.folder,
      //           color: Colors.blue.shade400,
      //           size: 30,
      //       ),
      //       onPressed: () => navigateBottomNavBar(4),
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.account_circle,
      //           color: Colors.blue.shade400,
      //           size: 30,
      //       ),
      //       onPressed: () => navigateBottomNavBar(3),
      //     ),
      //   ],
      // ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   onPressed: () => {navigateBottomNavBar(2)},
      //   child: Icon(CupertinoIcons.camera_fill,
      //       color: Colors.blue.shade800),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
