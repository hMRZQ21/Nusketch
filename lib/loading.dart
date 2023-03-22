import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/homepage.dart';
import 'package:nusketch/pages/loginpage.dart';
import 'package:nusketch/pages/mainpage.dart';
import 'package:nusketch/pages/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:nusketch/util/dimension.dart';
//
//
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

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();

    Future.delayed(const Duration(seconds: 2), () {
      FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) {
        if (user == null) {
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
          print('User is currently signed out!');
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainPage()),
          );
          print('User is signed in!');
        }
      });

    _animationController.dispose();
    });
  }

  // child:  Image(image:AssetImage("figures/full_title_png.png")),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox.expand(
            // will become as large as the screen size
            // fit: BoxFit.fill,
            child: FittedBox(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(image: AssetImage("figures/Title_P1.png")),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    // child:Image(image:AssetImage("figures/Title_Spin.png")),
                    child: AnimatedBuilder(
                        animation: _animationController,
                        child: const Image(
                            image: AssetImage("figures/Title_Spin.png")),
                        builder: (context, child) {
                          return RotationTransition(
                            turns: Tween(begin: 0.0, end: 1.0)
                                .animate(_animationController),
                            // angle: _animationController.value * 2.0 * math.pi,
                            child: child,
                          );
                        }),
                  ),
                  const Image(image: AssetImage("figures/Title_P2.png")),
                ],
              ),
            ),
          ),
        ));
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Row(
//           children: [
//             Container(
//               width: Dimension.page200w,
//               height: Dimension.page150h,
//               margin: EdgeInsets.only(
//                   left: Dimension.page13w, right: Dimension.page2w),
//               decoration: const BoxDecoration(
//                 color: Colors.black,
//                 image: DecorationImage(
//                   image: AssetImage(
//                     "figures/Title 1.png",
//                   ),
//                 ),
//               ),
//             ),
//             AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return Transform.rotate(
//                     origin: Offset(0, Dimension.page16_8w),
//                     angle: _animationController.value * 2 * pi,
//                     child: child);
//               },
//               child: Container(
//                 width: Dimension.page50w,
//                 height: Dimension.page50h,
//                 margin: EdgeInsets.only(
//                     top: Dimension.page35h, right: Dimension.page2w),
//                 decoration: const BoxDecoration(
//                   color: Colors.black,
//                   image: DecorationImage(
//                     image: AssetImage(
//                       "figures/Title spin.png",
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: Dimension.page140w,
//               height: Dimension.page170h,
//               margin: EdgeInsets.only(top: Dimension.page8h),
//               decoration: const BoxDecoration(
//                 color: Colors.black,
//                 image: DecorationImage(
//                   image: AssetImage(
//                     "figures/Title 2.png",
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
