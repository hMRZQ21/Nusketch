import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nusketch/util/dimension.dart';
import 'package:path_provider/path_provider.dart';

import '../util/colors.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

// TODO: fix sizing of page
class _UploadPageState extends State<UploadPage> {
  String selectedImage = 'figures/late.png';
  void updateSelectedImage(String image) {
    setState(() {
      selectedImage = image;
    });
  }

  Future<Uint8List> _loadImage() async {
    final ByteData imageData = await rootBundle.load(selectedImage);
    return imageData.buffer.asUint8List();
  }

  List<String> imageList = const [
    'figures/late.png',
    'figures/frogsad.png',
    'figures/think.png',
    'figures/catface.png',
    'figures/womenyell.png',
    'figures/lazycat.png',
    'figures/catstand.png',
    'figures/sani.png',
    'figures/meleaving.png',
    'figures/dogheli.png',
    'figures/catstare.png',
    'figures/csmeme.png',
    'figures/frogsmol.png',
    'figures/porki.png',
    'figures/catfly.png',
    'figures/sharkcat.png',
    'figures/headphones.png',
    'figures/duckhelp.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.beige2,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              Uint8List image = (await _loadImage());

              final grayscaleImage = img.grayscale(img.decodeImage(image)!);
              final grayscaleBytes = img.encodePng(grayscaleImage);

              // invert the grayscale
              final invertedImage1 = img.invert(grayscaleImage);

              // blur the inverted grayscale
              final blurredImage = img.gaussianBlur(invertedImage1, radius: 15);

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
              final images = await picture.toImage(
                  size.width.toInt(), size.height.toInt());

              // Get the bytes of the new image and save it
              final bytess =
                  await images.toByteData(format: ui.ImageByteFormat.png);

              // invert those bytes
              final invertedImage2 =
                  img.invert(img.decodeImage(bytess!.buffer.asUint8List())!);
              final invertedBytes2 = img.encodePng(invertedImage2);

              // Save the inverted image again naming convension
              final now = DateTime.now();
              final fileName =
                  '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}.png';
              Directory? directory = Platform.isAndroid
                  ? await getExternalStorageDirectory() //FOR ANDROID
                  : await getApplicationSupportDirectory();
              print(directory);
              final completed = '${directory?.path}/$fileName';

              // Save the file
              await File(completed).writeAsBytes(invertedBytes2, flush: true);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    // Pass the automatically generated path to the DisplayPictureScreen widget.
                    imagePath: completed,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: Dimension.screenHeight * 0.48,
            width: Dimension.screenWidth,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(247, 235, 219, 1),
                  offset: Offset(0, 18),
                  blurRadius: 5,
                ),
                BoxShadow(
                  color: Color.fromRGBO(238, 209, 170, 1),
                  offset: Offset(0, 12),
                  blurRadius: 5,
                ),
                BoxShadow(
                  color: Color.fromRGBO(222, 184, 135, 1),
                  offset: Offset(0, 6),
                  blurRadius: 5,
                ),
              ],
              color: CustomColors.beige2,
              image: DecorationImage(
                image: AssetImage(selectedImage),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: SizedBox(
                height: Dimension.screenHeight * 0.4,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: (imageList.length / 3).ceil(),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            updateSelectedImage(imageList[index * 3]);
                          },
                          child: Container(
                            width: Dimension.screenWidth * 0.28,
                            height: Dimension.screenHeight * 0.16,
                            child: Image(
                                image: AssetImage(imageList[index * 3]),
                                fit: BoxFit.cover),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            updateSelectedImage(imageList[index * 3 + 1]);
                          },
                          child: Container(
                            width: Dimension.screenWidth * 0.28,
                            height: Dimension.screenHeight * 0.16,
                            child: Image(
                                image: AssetImage(imageList[index * 3 + 1]),
                                fit: BoxFit.cover),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            updateSelectedImage(imageList[index * 3 + 2]);
                          },
                          child: Container(
                            width: Dimension.screenWidth * 0.28,
                            height: Dimension.screenHeight * 0.16,
                            child: Image(
                                image: AssetImage(imageList[index * 3 + 2]),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
