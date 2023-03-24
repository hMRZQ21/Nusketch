import 'package:flutter/material.dart';
import 'package:nusketch/util/dimension.dart';

import '../util/colors.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

// TODO: fix sizing of page
class _UploadPageState extends State<UploadPage> {
  AssetImage selectedImage = AssetImage('figures/late.png');
  void updateSelectedImage(AssetImage image) {
    setState(() {
      selectedImage = image;
    });
  }

  List<AssetImage> imageList = const [
    AssetImage('figures/late.png'),
    AssetImage('figures/frogsad.png'),
    AssetImage('figures/think.png'),
    AssetImage('figures/catface.png'),
    AssetImage('figures/womenyell.png'),
    AssetImage('figures/lazycat.png'),
    AssetImage('figures/catstand.png'),
    AssetImage('figures/sani.png'),
    AssetImage('figures/meleaving.png'),
    AssetImage('figures/dogheli.png'),
    AssetImage('figures/catstare.png'),
    AssetImage('figures/csmeme.png'),
    AssetImage('figures/frogsmol.png'),
    AssetImage('figures/porki.png'),
    AssetImage('figures/catfly.png'),
    AssetImage('figures/sharkcat.png'),
    AssetImage('figures/headphones.png'),
    AssetImage('figures/duckhelp.png'),
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
            onPressed: () {
              // Handle submit button press
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
                image: selectedImage,
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
                                image: imageList[index * 3], fit: BoxFit.cover),
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
                                image: imageList[index * 3 + 1],
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
                                image: imageList[index * 3 + 2],
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
