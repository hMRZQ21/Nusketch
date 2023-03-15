import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nusketch/util/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ConvertLoadingScreen extends StatefulWidget{
  const ConvertLoadingScreen({super.key});

  @override
  State<ConvertLoadingScreen> createState() => _ConvertLoadingScreenState();

}
class _ConvertLoadingScreenState extends State<ConvertLoadingScreen>{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          color: CustomColors.beige2,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                 Text(
                  "Loading . . .",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

             SpinKitThreeInOut(
               size: 80,
               itemBuilder: (BuildContext context, int index){
                 final colors = [Colors.white,Colors.pinkAccent,Colors.blueAccent,Colors.orangeAccent];
                 final color = colors[index%colors.length];
                 return DecoratedBox(
                     decoration: BoxDecoration(
                       color: color,
                       shape: BoxShape.circle,

                     ),
                 );
               },

              ),
                  ],
                ),
            ),
          ),
      );
  }

}