import 'package:flutter/material.dart';
import 'package:nusketch/home/body.dart';
import 'package:nusketch/util/colors.dart';
import 'package:nusketch/util/dimension.dart';

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
              margin: EdgeInsets.only(
                  top: Dimension.page40h, right: Dimension.page8w),
              child: const Icon(Icons.menu, color: Colors.blue, size: 50),
            ),
          ),
          const Expanded(
            // contains the scrollable view of content, which does not render until bodyView widget is called, located in body.dart
            child: SingleChildScrollView(
              child: bodyView(),
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
                Container(),
                const Expanded(
                  // Expanded takes each element for a portion flex 33 will take up 33% of entire screenWidth
                  flex: 33,
                  child:
                      Icon(Icons.home_outlined, color: Colors.blue, size: 55),
                ),
                const Expanded(
                  flex: 33,
                  child: Icon(Icons.camera_alt_outlined,
                      color: Colors.blue, size: 50),
                ),
                const Expanded(
                  flex: 33,
                  child: Icon(Icons.file_upload_outlined,
                      color: Colors.blue, size: 50),
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
