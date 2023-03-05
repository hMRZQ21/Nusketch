import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import '../util/colors.dart';
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
        backgroundColor: CustomColors.beige2,
        body: SafeArea(
          child: Column(
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
                    margin:
                        EdgeInsets.only(right: Dimension.screenWidth * 0.05),
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
                  child: _image == null
                      ? Container(
                          height: Dimension.screenHeight * 0.75,
                          width: Dimension.screenWidth,
                          color: Colors.blue.shade100,
                          child: Image(
                              image: AssetImage('figures/background.png'),
                              fit: BoxFit.fill),
                        )
                      : Image.file(
                          _image!,
                        ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoButton(
                        onPressed: null,
                        child: Container(
                            height: Dimension.screenWidth * 0.12,
                            child: Image(
                              image: AssetImage('figures/late.png'),
                            )),
                      ),
                      CupertinoButton(
                        onPressed: _getImage,
                        child: Icon(
                          CupertinoIcons.circle,
                          size: Dimension.screenWidth * 0.17,
                        ),
                      ),
                      CupertinoButton(
                        onPressed: _getGallery,
                        child: Icon(
                          CupertinoIcons.switch_camera,
                          size: Dimension.screenWidth * 0.12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
