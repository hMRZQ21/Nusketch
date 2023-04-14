import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import '../util/colors.dart';
import '../util/dimension.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

import 'drawingPage/artpage.dart';

double blurRadius = 12.0;

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

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera, create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      ResolutionPreset.high,
      imageFormatGroup:
          ImageFormatGroup.yuv420, // compatible with both ios and android
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
      appBar: AppBar(title: const Text('Drag slider for amount of shading')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Column(
              children: [
                Expanded(child: CameraPreview(_controller)),
                Container(
                  width: Dimension.screenWidth * 0.7,
                  child: Slider(
                    value: blurRadius,
                    min: 1,
                    max: 20,
                    onChanged: (value) {
                      setState(() {
                        blurRadius = value;
                      });
                    },
                  ),
                ),
                Text(
                  blurRadius.toStringAsFixed(0),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            );
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

            // accesses internal/external storage based on OS by ternary statement
            Directory? directory = Platform.isAndroid
                ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory(); //FOR iOS

            // file name
            final now = DateTime.now();
            final fileName =
                '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}.png';
            // save image into dir
            final savedImage = await File('${directory?.path}/$fileName')
                .writeAsBytes(await image.readAsBytes());

            // read image and then convert to grayscale
            final bytes = await savedImage.readAsBytes();
            final grayscaleImage = img.grayscale(img.decodeImage(bytes)!);
            final grayscaleBytes = img.encodePng(grayscaleImage);

            // invert the grayscale
            final invertedImage1 = img.invert(grayscaleImage);
            // final invertedBytes1 = img.encodePng(invertedImage1);

            // blur the inverted grayscale
            final blurredImage =
                img.gaussianBlur(invertedImage1, radius: blurRadius.toInt());
            // final blurredBytes = img.encodePng(blurredImage);

            // invert the blurred inverted grayscale
            final invertedImage = img.invert(blurredImage);
            final invertedBytes = img.encodePng(invertedImage);

            // decode the bytes
            final image1 = await decodeImageFromList(grayscaleBytes);
            final image2 = await decodeImageFromList(invertedBytes);

            // find the size of the image
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

            // invert those bytes
            final invertedImage2 =
                img.invert(img.decodeImage(bytess!.buffer.asUint8List())!);
            final invertedBytes2 = img.encodePng(invertedImage2);

            // Save the inverted image again naming convension
            final invertedFileName2 =
                fileName.replaceFirst('.png', '_completed.png');
            final invertedPath2 = '${directory?.path}/$invertedFileName2';

            // Save the file
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
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      // body: Image.file(File(imagePath)),
      body: ArtPage(
          ValueNotifier<Color>(Colors.black), // set initial color
          imagePath),
    );
  }
}
