import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'painter.dart';

class ArtPage extends StatefulWidget {
  const ArtPage({super.key});
  @override
  State<ArtPage> createState() => _ArtPage();
}

class _ArtPage extends State<ArtPage> {
  bool _canSee = true;
  TextEditingController toggle = TextEditingController();
  List<DrawingPoint> drawingPoints = [];
  double strokeWidth = 5;

  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
    print("Selected color: $pickerColor");
  }

  void pickColor(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Pick your color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
              ),
              TextButton(
                onPressed: () {
                  setState(() => currentColor = pickerColor);
                  Navigator.of(context).pop();
                  print("Current color: ${currentColor}");
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        ),
      );

  void hideWidget() {
    setState(() {
      _canSee = !_canSee;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom, //This line is used for showing the bottom bar
    ]);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            buildCurrentPath(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: AnimatedOpacity(
                    opacity: _canSee ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.list_alt)),
                            const Text("Menu"),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                            const Text("Filler"),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                pickColor(context);
                              },
                              icon: const Icon(Icons.color_lens_rounded),
                              color: currentColor,
                            ),
                            const Text("Colors"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          hideWidget();
                          _canSee ? toggle.text = 'Hide' : toggle.text = 'Show';
                          print(toggle.text);
                        },
                        icon: const Icon(Icons.menu)),
                    Text(toggle.text),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        drawingPoints.add(
          DrawingPoint(
            details.localPosition,
            Paint()
              ..color = currentColor
              ..isAntiAlias = true
              ..strokeWidth = strokeWidth
              ..strokeCap = StrokeCap.round,
          ),
        );
        print('User started drawing');
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.globalPosition);
        print(point);
      },
      onPanUpdate: (details) {
        setState(() {
          drawingPoints.add(
            DrawingPoint(
              details.localPosition,
              Paint()
                ..color = currentColor
                ..isAntiAlias = true
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
            ),
          );
        });
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.globalPosition);
        print(point);
      },
      onPanEnd: (details) {
        setState(() {
          drawingPoints.add(null);
        });
      },
      child: RepaintBoundary(
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // CustomPaint widget will go here
          child: CustomPaint(
            painter: MyCustomPainter(drawingPoints),
          ),
        ),
      ),
    );
  }
}

class DrawingPoint {
  final Offset offset;
  final Paint paint;

  DrawingPoint(this.offset, this.paint);
}
