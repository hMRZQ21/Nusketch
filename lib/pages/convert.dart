import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class ConvertSketch extends StatelessWidget {
  final ui.Image image;

  const ConvertSketch({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _Converting(image),
      ),
    );
  }
}

class _Converting extends CustomPainter {
  final ui.Image image;
  _Converting(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final pictureRecorder = PictureRecorder();
    final recorderCanvas = Canvas(pictureRecorder);

    recorderCanvas.drawImage(image, Offset.zero, Paint());
    recorderCanvas.drawImage(image, Offset.zero,
        Paint()..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5));
    // need to create custom class for grayscale.
    // recorderCanvas.drawImage(
    //     image, Offset.zero, Paint()..imageFilter = ImageFilter.grayscale);
    final picture = pictureRecorder.endRecording();
    canvas.drawPicture(picture);
  }

  @override
  bool shouldRepaint(_Converting oldDelegate) {
    return image != oldDelegate.image;
  }
}
