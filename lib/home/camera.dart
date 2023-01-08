import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  final imagePicker = ImagePicker();

  Future _getImage() async {
    File picture =
        (await imagePicker.pickImage(source: ImageSource.camera)) as File;
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
          margin: const EdgeInsets.only(top: 400),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 300),
                child: Center(
                  child: _image == null
                      ? const Text('No image yet')
                      : Image.file(_image!),
                ),
              ),
              FloatingActionButton(
                onPressed: _getImage,
                child: const Icon(Icons.camera_alt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
