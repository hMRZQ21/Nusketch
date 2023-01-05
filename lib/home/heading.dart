import 'package:flutter/material.dart';
import 'package:nusketch/home/body.dart';
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
        body: Column(
      children: [
        const Expanded(
          child: SingleChildScrollView(
            child: bodyView(),
          ),
        ),
        Container(
          height: Dimension.page70h,
          width: Dimension.screenWidth,
          margin: const EdgeInsets.only(top: 40),
          color: Colors.white,
        ),
      ],
    ));
  }
}
