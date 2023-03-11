import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../util/colors.dart';
import '../../util/dimension.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _initCameraController();
  }

  // Future<File> convertToSketch(XFile imageFile) async {
  //   // Load the image using the image package
  //   final image = img.decodeImage(await imageFile.readAsBytes());

  //   // Convert the image to grayscale
  //   final grayscale = img.grayscale(image!);

  //   // Apply a Gaussian blur to the grayscale image to smooth it out
  //   final blurred = img.gaussianBlur(grayscale, 10);

  //   // Invert the colors of the blurred image to create a negative image
  //   final inverted = img.invert(blurred);

  //   // Create a new File object and write the sketch image to it
  //   final sketchFile = File('${imageFile.path}_sketch.jpg');
  //   await sketchFile.writeAsBytes(img.encodeJpg(inverted));

  //   // Return the File object
  //   return sketchFile;
  // }

  Future<void> _takePicture() async {
    try {
      final imageFile = await _cameraController.takePicture();
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now()}.jpg';
      final imagePath = '${appDir.path}/$fileName';
      await imageFile.saveTo(imagePath);
      setState(() {
        _imageFile = XFile(imagePath);
      });
    } catch (e) {
      print(e);
    }
  }

  void _initCameraController() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(firstCamera, ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() {});

    // if (cameras.isNotEmpty) {
    //   _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    //   _cameraController.initialize().then((_) {
    //     if (!mounted) {
    //       return;
    //     }
    //     setState(() {});
    //   });
    // }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.beige2,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimension.screenWidth * 0.03,
                    bottom: Dimension.screenWidth * 0.03),
                margin: EdgeInsets.only(left: Dimension.screenWidth * 0.05),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Colors.blue,
                    size: Dimension.screenWidth * 0.08,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: Dimension.screenWidth * 0.03,
                    bottom: Dimension.screenWidth * 0.03),
                margin: EdgeInsets.only(right: Dimension.screenWidth * 0.05),
                child: Icon(
                  Icons.flash_off,
                  color: Colors.blue,
                  size: Dimension.screenWidth * 0.08,
                ),
              ),
            ],
          ),
          Container(
            height: Dimension.screenHeight * 0.80,
            color: CustomColors.beige2,
            child: Center(
              child: _imageFile == null
                  ? _cameraController.value.isInitialized
                      ? Container(
                          height: Dimension.screenHeight * 0.70,
                          child: AspectRatio(
                            aspectRatio: _cameraController.value.aspectRatio,
                            child: CameraPreview(_cameraController),
                          ),
                        )
                      : Container(
                          height: Dimension.screenHeight * 0.70,
                          color: Colors.red)
                  : Container(),
              // : Image.file(_imageFile! as File),
            ),
          ),
          Expanded(
            child: Container(
              child: CupertinoButton(
                onPressed: () {
                  _takePicture();
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: CustomColors.beige2,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    CupertinoIcons.circle,
                    size: Dimension.screenWidth * 0.17,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
