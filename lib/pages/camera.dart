import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../util/colors.dart';
import '../util/dimension.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io';
// import 'package:opencv/opencv.dart'; // this doesn't work

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<TakePictureScreen> createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<ui.Image> loadImage(String path) async {
    final Uint8List bytes = await new File(path).readAsBytes();
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera, create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(
                _controller); // If the Future is complete, display the preview.
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image` where it was saved.
            final image = await _controller.takePicture();
            if (!mounted) return;

            final directory = await getExternalStorageDirectory();
            final now = DateTime.now();
            final fileName =
                '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}.png';

            final savedImage = await File('${directory?.path}/$fileName')
                .writeAsBytes(await image.readAsBytes());

            final bytes = await savedImage.readAsBytes();
            final grayscaleImage = img.grayscale(img.decodeImage(bytes)!);
            final grayscaleBytes = img.encodePng(grayscaleImage);

            final grayscaleFileName =
                fileName.replaceFirst('.png', '_grayscale.png');
            final grayscalePath = '${directory?.path}/$grayscaleFileName';

            await File(grayscalePath).writeAsBytes(grayscaleBytes, flush: true);

            final invertedImage1 = img.invert(grayscaleImage);
            final invertedBytes1 = img.encodePng(invertedImage1);
            final invertedFileName1 = grayscaleFileName.replaceFirst(
                '_grayscale.png', '_inverted1.png');
            final invertedPath1 = '${directory?.path}/$invertedFileName1';

            await File(invertedPath1).writeAsBytes(invertedBytes1, flush: true);

            final blurredImage = img.gaussianBlur(invertedImage1, radius: 15);
            final blurredBytes = img.encodePng(blurredImage);

            final blurredFileName = invertedFileName1.replaceFirst(
                '_inverted1.png', '_blurred.png');
            final blurredPath = '${directory?.path}/$blurredFileName';

            await File(blurredPath).writeAsBytes(blurredBytes, flush: true);

            final invertedImage = img.invert(blurredImage);
            final invertedBytes = img.encodePng(invertedImage);
            final invertedFileName =
                blurredFileName.replaceFirst('_blurred.png', '_inverted.png');
            final invertedPath = '${directory?.path}/$invertedFileName';

            await File(invertedPath).writeAsBytes(invertedBytes, flush: true);

            final image1 = await loadImage(grayscalePath);
            final image2 = await loadImage(invertedPath);

            final size =
                ui.Size(image1.width.toDouble(), image1.height.toDouble());

// Create a Paint object with the bitwise division blend mode
            final paint = Paint()..blendMode = BlendMode.difference;

// Create a new canvas and draw the images with the Paint object
            final recorder = ui.PictureRecorder();
            final canvas = Canvas(recorder);
            canvas.drawImage(image1, Offset.zero, paint);
            canvas.drawImage(image2, Offset.zero, paint);

// Convert the canvas into an image
            final picture = recorder.endRecording();
            final images =
                await picture.toImage(size.width.toInt(), size.height.toInt());

// Get the bytes of the new image and save it
            final bytess =
                await images.toByteData(format: ui.ImageByteFormat.png);
            final differenceFileName = invertedFileName.replaceFirst(
                '_inverted.png', '_difference.png');

            final path = '${directory?.path}/$differenceFileName';
            await File(path)
                .writeAsBytes(bytess!.buffer.asUint8List(), flush: true);

            final invertedImage2 =
                img.invert(img.decodeImage(bytess!.buffer.asUint8List())!);
            final invertedBytes2 = img.encodePng(invertedImage2);

// Save the inverted image again
            final invertedFileName2 = differenceFileName.replaceFirst(
                '_difference.png', '_completed.png');
            final invertedPath2 = '${directory?.path}/$invertedFileName2';

            await File(invertedPath2).writeAsBytes(invertedBytes2, flush: true);

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to the DisplayPictureScreen widget.
                  imagePath: invertedPath2,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// default widget that displays the picture taken by the user.
// this overrides the UI we designed, scroll below for the original build widget
// below is also the original camera code made by willie
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
