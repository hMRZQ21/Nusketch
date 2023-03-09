import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/description.dart';
import 'package:nusketch/util/dimension.dart';

import '../util/colors.dart';

class AgencyView extends StatefulWidget {
  final String agency;

  const AgencyView({super.key, required this.agency});

  @override
  State<AgencyView> createState() => _AgencyViewState();
}

class _AgencyViewState extends State<AgencyView> {
  final List<String> art = [
    "figures/example1.png",
    "figures/example2.png",
    "figures/example3.png",
    "figures/example4.png",
    "figures/example5.png",
    "figures/example6.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return Column(
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
}
