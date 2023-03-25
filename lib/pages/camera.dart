import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
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

            final blurredImage = img.gaussianBlur(invertedImage1, radius: 4);
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

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to the DisplayPictureScreen widget.
                  imagePath: invertedPath,
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


// class CameraPage extends StatefulWidget {
//   const CameraPage({Key? key});

//   @override
//   State<TakePictureScreen> createState() => TakePictureScreenState();
// }

// class _CameraPageState extends State<CameraPage> {
//   List<CameraDescription> cameras = [];
//   late CameraController _cameraController;
//   XFile? _imageFile;
//   int currentCameraIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await _getPermission();
//       cameras = await availableCameras();
//       await _initCameraController();
//     });
//   }

// Future<void> _getPermission() async {
//   if (await Permission.camera.request().isGranted) {
//     print("Permission is granted");
//   } else {
//     print("Permission is not granted");
//   }
// }

// Future<File> convertToSketch(XFile imageFile) async {
// Load the image using the image package
// final image = img.decodeImage(await imageFile.readAsBytes());

// final grayscale = img.grayscale(image!);
// final blurred = img.gaussianBlur(grayscale, 10);

// Create a new image with the same dimensions as the original
// final thresholded = img.Image(image.width, image.height);

// Loop through all the pixels and set them to black or white based on their intensity
// const threshold = 190;
// for (int y = 0; y < image.height; y++) {
//   for (int x = 0; x < image.width; x++) {
//     final pixel = blurred.getPixel(x, y);
//     final intensity = img.getLuminance(pixel);
//     final color = intensity > threshold ? 255 : 0;
//     thresholded.setPixel(x, y, img.Color.fromRgb(color, color, color));
//   }
// }

// final inverted = img.invert(thresholded);

// Create a new File object and write the sketch image to it
// final sketchFile = File('${imageFile.path}_sketch.jpg');
// await sketchFile.writeAsBytes(img.encodeJpg(inverted));

// Return the File object
// return sketchFile;
// }

// Future<void> _takePicture() async {
//   if (await Permission.camera.request().isGranted) {
//     final XFile imageFile = await _cameraController.takePicture();
//     // final File sketchFile = await convertToSketch(imageFile);

//     // setState(() {
//     // _imageFile = XFile(sketchFile.path);
//     // });
//   } else {
//     print("Permission is not granted");
//   }
// }

// void _switchCamera() async {
//   if (cameras.isEmpty) {
//     return;
//   }
//   currentCameraIndex = (currentCameraIndex + 1) % cameras.length;
//   await _cameraController.dispose();
//   await _initCameraController();
// }

// @override
// void dispose() {
//   _cameraController.dispose();
//   super.dispose();
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColors.beige2,
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: EdgeInsets.only(
//                     top: Dimension.screenWidth * 0.03,
//                     bottom: Dimension.screenWidth * 0.03),
//                 margin: EdgeInsets.only(left: Dimension.screenWidth * 0.05),
//                 child: IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: Icon(
//                     Icons.close,
//                     color: Colors.blue,
//                     size: Dimension.screenWidth * 0.08,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(
//                     top: Dimension.screenWidth * 0.03,
//                     bottom: Dimension.screenWidth * 0.03),
//                 margin: EdgeInsets.only(right: Dimension.screenWidth * 0.05),
//                 child: IconButton(
//                   onPressed: () => _switchCamera(),
//                   icon: Icon(
//                     Icons.flash_off,
//                     color: Colors.blue,
//                     size: Dimension.screenWidth * 0.08,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             height: Dimension.screenHeight * 0.80,
//             color: CustomColors.beige2,
//             child: Center(
//               child: _imageFile == null
//                   ? _cameraController.value.isInitialized
//                       ? Container(
//                           height: Dimension.screenHeight * 0.70,
//                           child: AspectRatio(
//                             aspectRatio: _cameraController.value.aspectRatio,
//                             child: CameraPreview(_cameraController),
//                           ),
//                         )
//                       : Container(
//                           height: Dimension.screenHeight * 0.70,
//                           color: Colors.red)
//                   : Container(
//                       child: Transform.rotate(
//                         angle: -90 * math.pi / 180,
//                         child: Image.file(
//                           File(_imageFile!.path),
//                         ),
//                       ),
//                     ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               child: CupertinoButton(
//                 onPressed: () {
//                   _takePicture();
//                   if (_imageFile != null) {
//                     print("not null");
//                   }
//                 },
//                 child: Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: CustomColors.beige2,
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                   child: Icon(
//                     CupertinoIcons.circle,
//                     size: Dimension.screenWidth * 0.17,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
