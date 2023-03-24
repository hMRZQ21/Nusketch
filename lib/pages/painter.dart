import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/artpage.dart';

// class Painter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: Colors.yellow[100],
//       child: CustomPaint(
//         painter: MyCustomPainter(drawingPoints),
//       ),
//     );
//   }
//
// }
class MyCustomPainter extends CustomPainter {
   final List<DrawingPoint> drawingPoints;
   MyCustomPainter(this.drawingPoints);
   List<Offset> offsetsList= [];
  @override
  void paint(Canvas canvas, Size size) {
    for(int i = 0; i < drawingPoints.length -1; i++){
      if(drawingPoints[i] != null && drawingPoints[i+1] != null){
        canvas.drawLine(drawingPoints[i].offset,drawingPoints[i+1].offset,drawingPoints[i].paint);
      }else if(drawingPoints[i] != null && drawingPoints[i+1] == null){
        offsetsList.clear();
        offsetsList.add(drawingPoints[i].offset);
        canvas.drawPoints(PointMode.points, offsetsList, drawingPoints[i].paint);
      }
    }
  }

  // 4
  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}