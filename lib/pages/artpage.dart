import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:nusketch/pages/drawingcanvas.dart';
import 'painter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ArtPage extends HookWidget {
   ValueNotifier<Color> selectedColor;

  bool _canSee = true;
  TextEditingController toggle = TextEditingController();

  double strokeWidth = 5;

  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  ArtPage(this.selectedColor, {super.key});


  pickColor(BuildContext context, ValueNotifier<Color> color) => {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Pick your color'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: (value) {
                    color.value = value;
                    pickerColor = value;
                    print("Color changed to: ${value}");
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {

                    Navigator.of(context).pop();
                    print("Current color: ${selectedColor}");
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        ),
      };

  hideWidget() {
    useState(() {
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
            DrawingCanvas(
              selectedColor: selectedColor,
            ),
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
                                onPressed: () {},
                                icon: const Icon(Icons.list_alt)),
                            const Text("Menu"),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.add)),
                            const Text("Filler"),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                pickColor(context, selectedColor);
                                print("icon clicked ${selectedColor.value} ");
                              },
                              icon: const Icon(Icons.color_lens_rounded),
                              color: selectedColor.value,
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
                          _canSee ? toggle.text = 'Hide' : toggle.text = 'Show';
                          print(toggle.text);
                        },
                        icon: const Icon(Icons.menu,)),
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
}
