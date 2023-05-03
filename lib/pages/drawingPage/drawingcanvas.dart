import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:nusketch/pages/drawingPage/painter.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

final GlobalKey _grab = GlobalKey();

class DrawingCanvas extends HookWidget {
  ValueNotifier<DrawingPoint?> currentSketch = useState(null);
  ValueNotifier<List<DrawingPoint>> allSketches = useState([]);
  ValueNotifier<Color> selectedColor;
  String path;
  // create some values
  TextEditingController toggle = TextEditingController();

  DrawingCanvas({
    Key? key,
    required this.path,
    required this.selectedColor,
  }) : super(key: key);

// ValueChanged<Color> callback

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RepaintBoundary(
          key: _grab,
          child: Stack(
            children: [
              buildAllPaths(context),
              buildCurrentPath(context),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () async {
              // show popup dialog
              final textController = TextEditingController();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Enter Text'),
                    content: TextField(
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          filled: true,
                          hintText: "Your text here"),
                      controller: textController,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          await Future.delayed(const Duration(seconds: 1));
                          Navigator.pop(context, textController.text);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );

              // get entered text
              final text = textController.text;

              final boundary = _grab.currentContext!.findRenderObject()
                  as RenderRepaintBoundary;
              final image = await boundary.toImage();
              final byteData =
                  await image.toByteData(format: ui.ImageByteFormat.png);
              final pngBytes = byteData!.buffer.asUint8List();
              await File(path).writeAsBytes(pngBytes);
              File photo1 = File(path);
              pw.MemoryImage memoryImage =
                  pw.MemoryImage(photo1.readAsBytesSync());

              final pdf = pw.Document();
              pdf.addPage(
                pw.Page(
                  build: (pw.Context context) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Image(memoryImage, height: 700),
                      pw.Text(text),
                    ],
                  ),
                ),
              );
              final file = File("${path}.pdf");
              await file.writeAsBytes(await pdf.save());
            },
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }

  Widget buildAllPaths(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // CustomPaint widget will go here
        decoration: BoxDecoration(
          image: DecorationImage(
              image: FileImage(File(path)),
              fit: BoxFit.cover,
              opacity: 0.6 // adjust as needed
              ),
        ),
        child: CustomPaint(
          painter: MyCustomPainter(drawingPoints: allSketches.value),
        ),
      ),
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        print('User started drawing');
        final box = context.findRenderObject() as RenderBox;

        final offset = box.globalToLocal(details.globalPosition);
        currentSketch.value =
            DrawingPoint(points: [offset], color: selectedColor.value, size: 5);
        print(offset);
      },
      onPanUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.globalToLocal(details.globalPosition);
        final points = List<Offset>.from(currentSketch.value?.points ?? [])
          ..add(offset);
        currentSketch.value =
            DrawingPoint(points: points, color: selectedColor.value, size: 5);
        print(offset);
      },
      onPanEnd: (details) {
        allSketches.value = List<DrawingPoint>.from(allSketches.value)
          ..add(currentSketch.value!);
      },
      child: RepaintBoundary(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // CustomPaint widget will go here
          child: CustomPaint(
            painter: MyCustomPainter(
              drawingPoints:
                  currentSketch.value == null ? [] : [currentSketch.value!],
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(path)),
                    fit: BoxFit.cover,
                    opacity: 0.6 // adjust as needed
                    ),
              ),
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
