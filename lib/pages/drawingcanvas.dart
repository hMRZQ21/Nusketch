

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:nusketch/pages/painter.dart';

class DrawingCanvas extends HookWidget{
    ValueNotifier<DrawingPoint?> currentSketch = useState(null);
    ValueNotifier<List<DrawingPoint>> allSketches = useState([]);
    ValueNotifier<Color> selectedColor;
    // create some values
    TextEditingController toggle = TextEditingController();

    DrawingCanvas({
      Key? key,
      required this.selectedColor,
    }) : super(key: key);

// ValueChanged<Color> callback

  @override
  Widget build(BuildContext context) {
     return Stack(
       children: [
          buildAllPaths(context), 
          buildCurrentPath(context),
       ],
     );
  }

  Widget buildAllPaths(BuildContext context){
    return RepaintBoundary(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // CustomPaint widget will go here
        child: CustomPaint(
          painter: MyCustomPainter(
            drawingPoints: allSketches.value
          ),
        ),
      ),
    );
  }

  Widget buildCurrentPath(BuildContext context){
    return GestureDetector(
      onPanStart: (details) {
        print('User started drawing');
        final box = context.findRenderObject() as RenderBox;
        final offset = box.globalToLocal(details.globalPosition);
        currentSketch.value = DrawingPoint(points: [offset], color: selectedColor.value, size: 5);
        print(offset);
      },
      onPanUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.globalToLocal(details.globalPosition);
        final points = List<Offset>.from(currentSketch.value?.points ?? [])..add(offset);
        currentSketch.value = DrawingPoint(points: points, color:  selectedColor.value, size: 5);
        print(offset);
      },
      onPanEnd: (details) {
        allSketches.value = List<DrawingPoint>.from(allSketches.value)..add(currentSketch.value!);
       },
      child: RepaintBoundary(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // CustomPaint widget will go here
          child: CustomPaint(
            painter: MyCustomPainter(
              drawingPoints: currentSketch.value == null ? [] : [currentSketch.value!],
            ),
          ),
        ),
      ),
    );
  }
  }


class DrawingPoint {
  final List<Offset> points;
  final Color color;
  final double size;

  DrawingPoint({required this.points, required this.color, required this.size});
}