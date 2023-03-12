import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import '../util/colors.dart';
import '../util/dimension.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import 'dart:math' as math;

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription> cameras = [];
  late CameraController _cameraController;
  XFile? _imageFile;
  int currentCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getPermission();
      cameras = await availableCameras();
      await _initCameraController();
    });
  }

  Future<void> _getPermission() async {
    if (await Permission.camera.request().isGranted) {
      print("Permission is granted");
    } else {
      print("Permission is not granted");
    }
  }

  Future<File> convertToSketch(XFile imageFile) async {
    // Load the image using the image package
    final image = img.decodeImage(await imageFile.readAsBytes());

    final grayscale = img.grayscale(image!);
    final blurred = img.gaussianBlur(grayscale, 10);

// Create a new image with the same dimensions as the original
    final thresholded = img.Image(image.width, image.height);

// Loop through all the pixels and set them to black or white based on their intensity
    const threshold = 190;
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = blurred.getPixel(x, y);
        final intensity = img.getLuminance(pixel);
        final color = intensity > threshold ? 255 : 0;
        thresholded.setPixel(x, y, img.Color.fromRgb(color, color, color));
      }
    }

    final inverted = img.invert(thresholded);

    // Create a new File object and write the sketch image to it
    final sketchFile = File('${imageFile.path}_sketch.jpg');
    await sketchFile.writeAsBytes(img.encodeJpg(inverted));

    // Return the File object
    return sketchFile;
  }

  Future<void> _takePicture() async {
    if (await Permission.camera.request().isGranted) {
      final XFile imageFile = await _cameraController.takePicture();
      final File sketchFile = await convertToSketch(imageFile);

      setState(() {
        _imageFile = XFile(sketchFile.path);
      });
    } else {
      print("Permission is not granted");
    }
  }

  Future<void> _initCameraController() async {
    final cameras = await availableCameras();
    final CameraDescription camera = cameras[0];
    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: // image format supported for iOS
          ImageFormatGroup.yuv420,
    );
    await _cameraController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void _switchCamera() async {
    if (cameras.isEmpty) {
      return;
    }
    currentCameraIndex = (currentCameraIndex + 1) % cameras.length;
    await _cameraController.dispose();
    await _initCameraController();
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
                child: IconButton(
                  onPressed: () => _switchCamera(),
                  icon: Icon(
                    Icons.flash_off,
                    color: Colors.blue,
                    size: Dimension.screenWidth * 0.08,
                  ),
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
                  : Container(
                      child: Transform.rotate(
                        angle: -90 * math.pi / 180,
                        child: Image.file(
                          File(_imageFile!.path),
                        ),
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Container(
              child: CupertinoButton(
                onPressed: () {
                  _takePicture();
                  if (_imageFile != null) {
                    print("not null");
                  }
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
