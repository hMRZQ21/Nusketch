import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class bodyView extends StatefulWidget {
  const bodyView({super.key});

  @override
  State<bodyView> createState() => _bodyViewState();
}

class _bodyViewState extends State<bodyView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 2300,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, left: 30, bottom: 10),
                      child: const Text(
                        'Sketch of a girl',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 30, bottom: 10),
                      child: const Text(
                        'Monday October 24, 2022',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("img/girlimage1.png"),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
