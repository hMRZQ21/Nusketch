import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusketch/pages/description.dart';
import 'package:nusketch/util/dimension.dart';

import '../util/colors.dart';

class FolderView extends StatefulWidget {
  final String folder;
  final int folderIndex;

  const FolderView(
      {super.key, required this.folder, required this.folderIndex});

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  List<String> art = [
    "figures/example1.png",
    "figures/example2.png",
    "figures/example3.png",
    "figures/example4.png",
    "figures/example5.png",
    "figures/example6.png",
  ];

  List<ArtAndFolder> images = [
    ArtAndFolder(0, "figures/example1.png"),
    ArtAndFolder(1, "figures/example2.png"),
    ArtAndFolder(2, "figures/example3.png"),
    ArtAndFolder(3, "figures/example4.png"),
    ArtAndFolder(4, "figures/example5.png"),
    ArtAndFolder(0, "figures/example1.png"),
  ];

  List<String> indexImages = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < images.length; i++) {
      // print(images.folderIndex);
      // print(widget.folderIndex);
      if (images[i].folderIndex == widget.folderIndex) {
        indexImages.add(images[i].artName);
      }
      print(indexImages);
    }
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1000) {
        // phone
        return phone();
      } else {
        return phone(); // tablet
      }
    });
  }

  Widget phone() => Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: CustomColors.beige2,
          centerTitle: true,
          title: Text(
            '${widget.folder}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsets.all(MediaQuery.of(context).size.shortestSide * .05),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Wrap(
                  spacing: MediaQuery.of(context).size.shortestSide * .05,
                  runSpacing: MediaQuery.of(context).size.shortestSide * .05,
                  children: List.generate(indexImages.length, (index) {
                    return Column(
                      children: [
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.4,
                            child: Image.asset(indexImages[index])),
                      ],
                    );
                  })),
            ),
          ),
        ),
      );
  // Widget phone ()=> Scaffold(
  //   appBar: AppBar(
  //     elevation: 10,
  //     backgroundColor: CustomColors.beige2,
  //     title: Text(
  //       "Sketches",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   ),
  //   body: Container(
  //     child: ListView.builder(
  //       itemBuilder: (context, index) {
  //         int fitem = index * 2;
  //         int sitem = fitem + 1;
  //         return Row(
  //           children: [
  //             Column(
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.push(
  //                       context,
  //                       CupertinoPageRoute(
  //                           builder: (context) => DescriptionPage()),
  //                     );
  //                   },
  //                   child: Container(
  //                     width: Dimension.screenWidth / 2,
  //                     height: Dimension.page180h,
  //                     child: Container(
  //                       margin: EdgeInsets.only(top: Dimension.page35h),
  //                       child: Image(
  //                         image: AssetImage(art[fitem]),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Column(
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.push(
  //                       context,
  //                       CupertinoPageRoute(
  //                           builder: (context) => DescriptionPage()),
  //                     );
  //                   },
  //                   child: Container(
  //                     width: Dimension.screenWidth / 2,
  //                     height: Dimension.page180h,
  //                     child: Container(
  //                       margin: EdgeInsets.only(top: Dimension.page35h),
  //                       child: Image(
  //                         fit: BoxFit.fill,
  //                         image: AssetImage(
  //                           art[sitem],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       },
  //       itemCount: art.length ~/ 4,
  //       scrollDirection: Axis.vertical,
  //     ),
  //   ),
  // );
}

class ArtAndFolder {
  int folderIndex;
  String artName;

  ArtAndFolder(this.folderIndex, this.artName);
}
