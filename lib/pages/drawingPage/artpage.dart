import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:nusketch/pages/drawingPage/drawingcanvas.dart';
import 'painter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ArtPage extends HookWidget {
  ValueNotifier<Color> selectedColor;
  String path;
  TextEditingController toggle = TextEditingController();

  double strokeWidth = 5;

  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  ArtPage(this.selectedColor, this.path, {super.key});

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

  @override
  Widget build(BuildContext context) {
    final see = useState(true);
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
              path: path,
              selectedColor: selectedColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: AnimatedOpacity(
                    opacity: see.value ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            PopupMenuButton(
                              icon: const Icon(Icons.list_alt),
                              onSelected: choiceMade,
                              itemBuilder: (BuildContext bc) {
                                return const [
                                  PopupMenuItem(
                                    child: Text("Save"),
                                    value: '/about',
                                  ),
                                  PopupMenuItem(
                                    child: Text("Print"),
                                    value: '/contact',
                                  ),
                                ];
                              },
                            ),
                            const Text("Menu"),
                          ],

                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.add)),
                            const Text("Text"),
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
                          print(toggle.text);
                          see.value  = !see.value;
                          print(see.value);
                        },
                        icon: const Icon(
                          Icons.menu,
                        )),
                    Text(see.value ? toggle.text = 'Hide' : toggle.text = 'Show'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void choiceMade(String value) {
    print(value);
  }
}
