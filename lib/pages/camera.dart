import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import '../util/colors.dart';
import '../util/dimension.dart';
import 'package:image/image.dart' as img;

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
  bool _isImageCaptured = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cameras = await availableCameras();
      await _initCameraController();
    });
  }

  Future<void> _takePicture() async {
    try {
      _isImageCaptured = true;
      final imageFile = await _cameraController.takePicture();

      setState(() {
        _imageFile = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _initCameraController() async {
    final cameras = await availableCameras();
    final CameraDescription camera = cameras[currentCameraIndex];
    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
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
                      : Container()
                  : Image.file(_imageFile! as File),
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
