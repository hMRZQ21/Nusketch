import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

// need to add link to convert.dart

class _CameraPageState extends State<CameraPage> {
  File? _image;
  ImagePicker imagePicker = ImagePicker();

  Future _getImage() async {
    XFile? picture = await imagePicker.pickImage(source: ImageSource.camera);
    if (picture == null) {
      return;
    } else {
      File? image = File(picture.path);
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: _getImage,
                child: const Icon(Icons.camera_alt),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: _image == null
                      ? const Text('No image yet')
                      : Image.file(_image!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
