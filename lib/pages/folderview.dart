import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/description.dart';
import 'package:nusketch/util/dimension.dart';

import '../util/colors.dart';

class FolderView extends StatefulWidget {
  final String folder;

  const FolderView({super.key, required this.folder});

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth < 1000){ // phone
        return phone();
      }else{
        return phone(); // tablet
      }});
    }
  Widget phone ()=> Scaffold(
    appBar: AppBar(
      elevation: 10,
      backgroundColor: CustomColors.beige2,
      title: Text(
        "Sketches",
        style: TextStyle(color: Colors.white),
      ),
    ),
    body: Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          int fitem = index * 2;
          int sitem = fitem + 1;
          return Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => DescriptionPage()),
                      );
                    },
                    child: Container(
                      width: Dimension.screenWidth / 2,
                      height: Dimension.page180h,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimension.page35h),
                        child: Image(
                          image: AssetImage(art[fitem]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => DescriptionPage()),
                      );
                    },
                    child: Container(
                      width: Dimension.screenWidth / 2,
                      height: Dimension.page180h,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimension.page35h),
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            art[sitem],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        itemCount: art.length ~/ 2,
        scrollDirection: Axis.vertical,
      ),
    ),
  );
}
