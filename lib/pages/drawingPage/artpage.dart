import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:nusketch/pages/drawingPage/drawingcanvas.dart';
import 'package:nusketch/pages/drawingPage/textinfo.dart';
import 'painter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
TextEditingController textEditingController = TextEditingController();

class ArtPage extends HookWidget {
  ValueNotifier<Color> selectedColor;
  String path;
  bool _canSee = true;
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
              path: path,
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
                                  )
                                ];
                              },
                            ),
                            const Text("Menu"),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  addNewDialog(context);
                                },
                                icon: const Icon(Icons.add)),
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
                          _canSee ? toggle.text = 'Hide' : toggle.text = 'Show';
                          print(toggle.text);
                        },
                        icon: const Icon(
                          Icons.menu,
                        )),
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


  List<TextInfo> texts = [];
  addNewText(BuildContext context){
    useState(texts.add(TextInfo(
      text:textEditingController.text,
      left:0,
      top:0,
      color:Colors.black,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      textAlign: TextAlign.left,
      fontSize: 20,
    )));
  }

  Future addNewDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Add New Text"),
          content: TextField(
            controller: textEditingController,
            maxLines: 3,
            decoration: const InputDecoration(
                suffixIcon: Icon(Icons.edit),
                filled: true,
                hintText: "Your text here"),
          ),
          actions: <Widget>[
            DefaultButton(
                onPressed: () => Navigator.of(context).pop(),
                color: Colors.white,
                textColor: Colors.black,
                child: const Text("Back")),
            DefaultButton(
                onPressed: () => {addNewText(context)},
                color: Colors.red,
                textColor: Colors.white,
                child: const Text("Add Text"))
          ],
        ));
  }

  void choiceMade(String value) {
    print(value);
  }
}

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;

  const DefaultButton(
      {super.key,
        required this.onPressed,
        required this.color,
        required this.textColor,
        required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(color: textColor),
            )),
        onPressed: onPressed,
        child: child);
  }
}
