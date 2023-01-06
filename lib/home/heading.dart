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
      backgroundColor: CustomColors.mainpagebgcolor,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: Dimension.page50w,
              height: Dimension.page50h,
              margin: EdgeInsets.only(
                  top: Dimension.page40h, right: Dimension.page8w),
              child: const Icon(Icons.menu, color: Colors.blue, size: 50),
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: bodyView(),
            ),
          ),
          Container(
            height: Dimension.page70h,
            width: Dimension.screenWidth,
            margin: EdgeInsets.only(top: Dimension.page40h),
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
