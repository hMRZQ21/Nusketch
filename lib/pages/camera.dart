import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import '../util/dimension.dart';
//Todo implement backbutton to homescreen
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

  Future _getGallery() async {
    XFile? picture = await imagePicker.pickImage(source: ImageSource.gallery);
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
          body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimension.page100h),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: Dimension.page10h),
                  child: Center(
                    child: _image == null
                        ? Container(
                            height: Dimension.page550h,
                            width: Dimension.screenWidth,
                            color: Colors.blue.shade100,
                          )
                        : Image.file(
                            _image!,
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CupertinoButton(
                      onPressed: _getImage,
                      child: const Icon(
                        CupertinoIcons.photo_camera,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: _getGallery,
                      child: const Icon(CupertinoIcons.folder),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
