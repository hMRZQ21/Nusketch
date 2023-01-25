// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        body: Center(child: Text('body here')),
//        bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//             items: [
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
//               BottomNavigationBarItem(icon: Icon(Icons.camera_alt_rounded), label: 'camera'),
//               BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'upload'),
//             ],
//        ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:nusketch/pages/accountsettings.dart';
import 'package:nusketch/pages/camera.dart';
import 'package:nusketch/pages/description.dart';
import 'package:nusketch/util/colors.dart';
import 'package:nusketch/util/dimension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hamburgerShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  _hamburgerShow = !_hamburgerShow;
                },
              );
            },
            icon: const Icon(Icons.menu),
            color: Colors.blue,
          ),
        ],
      ),
      body: Stack(
        children: [
          _hamburgerShow
              ? Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 2),
                      width: Dimension.screenWidth,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                    ),
                    AnimatedPositioned(
                      duration: Duration(seconds: 2),
                      curve: Curves.easeInOut,
                      right: _hamburgerShow
                          ? 0.0
                          : MediaQuery.of(context).size.width,
                      top: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _hamburgerShow = !_hamburgerShow;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 2),
                              width: Dimension.screenWidth,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AccountSettings()),
                                      );
                                    },
                                    child: Container(
                                      width: 180,
                                      height: 45,
                                      margin:
                                          EdgeInsets.only(top: 30, bottom: 21),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      child: Center(
                                        child: Text("Account Settings"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 180,
                                    height: 45,
                                    margin: EdgeInsets.only(bottom: 21),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(21),
                                    ),
                                    child: Center(
                                      child: Text("Portfolios"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 5000,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 490,
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: Dimension.page20h,
                                    left: Dimension.page30w,
                                    bottom: Dimension.page10h),
                                child: const Text(
                                  'Sketch of a girl',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: Dimension.page30w,
                                    bottom: Dimension.page10h),
                                child: const Text(
                                  'Monday October 24, 2022',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: Dimension.outtercontainerw,
                                    height: Dimension.outtercontainerh,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimension.page10r),
                                        color: CustomColors.lavender),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DescriptionPage()),
                                      );
                                    },
                                    child: Container(
                                      width: Dimension.innerpicturew,
                                      height: Dimension.innerpictureh,
                                      margin: EdgeInsets.only(
                                          top: Dimension.page10h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimension.page10r),
                                        color: Colors.white,
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "figures/girlimage1.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
