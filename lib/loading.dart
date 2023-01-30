import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/mainpage.dart';
import 'package:nusketch/util/dimension.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
      _animationController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              width: Dimension.page200w,
              height: Dimension.page150h,
              margin: EdgeInsets.only(
                  left: Dimension.page13w, right: Dimension.page2w),
              decoration: const BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(
                    "figures/Title 1.png",
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                    origin: Offset(0, Dimension.page16_8w),
                    angle: _animationController.value * 2 * pi,
                    child: child);
              },
              child: Container(
                width: Dimension.page50w,
                height: Dimension.page50h,
                margin: EdgeInsets.only(
                    top: Dimension.page35h, right: Dimension.page2w),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage(
                      "figures/Title spin.png",
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: Dimension.page140w,
              height: Dimension.page170h,
              margin: EdgeInsets.only(top: Dimension.page8h),
              decoration: const BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(
                    "figures/Title 2.png",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
