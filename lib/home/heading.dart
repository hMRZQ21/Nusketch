import 'package:flutter/material.dart';
import 'package:nusketch/home/body.dart';
import 'package:nusketch/home/camera.dart';
import 'package:nusketch/home/upload.dart';
import 'package:nusketch/util/colors.dart';
import 'package:nusketch/util/dimension.dart';

import 'homepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyPageState();
}

class _MyPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          CustomColors.mainpagebgcolor, // uses colors.dart to set custom colors
      body: Column(
        // scaffold has a column widget that nests
        children: [
          // a vertical display of widgets
          Align(
            // hamburger dropdown icon
            alignment: Alignment.topRight,
            child: Container(
              // Dimension.page50w ... Dimensions is a widget name located in dimensions.dart, makes sizing dynamic and reuseble
              width: Dimension.page50w,
              height: Dimension.page50h,
              color: Colors.transparent.withOpacity(0),
              margin: EdgeInsets.only(
                  top: Dimension.page40h, right: Dimension.page8w),
              child: const Icon(Icons.menu, color: Colors.blue, size: 50),
            ),
          ),
          const Expanded(
            // contains the scrollable view of content, which does not render until bodyView widget is called, located in body.dart
            child: SingleChildScrollView(
              child: BodyView(),
            ),
          ),
          Container(
            // contains the 3 icons in the bottom portion
            height: Dimension.page70h,
            width: Dimension.screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimension.page20h),
                topRight: Radius.circular(Dimension.page20h),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Expanded takes each element for a portion flex 33 will take up 33% of entire screenWidth
                  flex: 33,
                  child: Container(
                    margin: EdgeInsets.only(bottom: Dimension.page20h),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                      icon: const Icon(Icons.home_outlined,
                          color: Colors.blue, size: 55),
                    ),
                  ),
                ),
                Expanded(
                  flex: 33,
                  child: Container(
                    margin: EdgeInsets.only(bottom: Dimension.page12h),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CameraPage()),
                        );
                      },
                      icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.blue, size: 50),
                    ),
                  ),
                ),
                Expanded(
                  flex: 33,
                  child: Container(
                    margin: EdgeInsets.only(bottom: Dimension.page20h),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UploadPage()),
                        );
                      },
                      icon: const Icon(Icons.file_upload_outlined,
                          color: Colors.blue, size: 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlatButton {}
