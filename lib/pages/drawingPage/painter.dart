import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/drawingPage/artpage.dart';

import 'drawingcanvas.dart';

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
  MyCustomPainter({required this.drawingPoints});

  @override
  void paint(Canvas canvas, Size size) {
    for (DrawingPoint point in drawingPoints) {
      final points = point.points;
      final path = Path();
      path.moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length - 1; i++) {
        final p0 = points[i];
        final p1 = points[i + 1];
        path.quadraticBezierTo(
            p0.dx, p0.dy, (p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
      }
      Paint paint = Paint()
        ..color = point.color
        ..strokeWidth = point.size
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }
  }

  // 4
  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}
