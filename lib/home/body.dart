import 'package:flutter/material.dart';
import 'package:nusketch/util/colors.dart';
import 'package:nusketch/util/dimension.dart';

class bodyView extends StatefulWidget {
  const bodyView({super.key});

  @override
  State<bodyView> createState() => _bodyViewState();
}

class _bodyViewState extends State<bodyView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // sizing depends on size of the elements it contains, should be made dynamic later
      height: 2400,
      child: ListView.builder(
        // NeverScrollableScrollPhysics makes scrolling the whole screen possible instead of the container only scrollable
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(
                      top: Dimension.page20h,
                      left: Dimension.page30w,
                      bottom: Dimension.page10h),
                  child: const Text(
                    'Sketch of a girl',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimension.page30w, bottom: Dimension.page10h),
                  child: const Text(
                    'Monday October 24, 2022',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Stack(
                // stack allows the containers or other widgets to be stacked on top of each other
                children: [
                  Align(
                    // outer blue container
                    alignment: Alignment.center,
                    child: Container(
                      width: Dimension.outtercontainerw,
                      height: Dimension.outtercontainerh,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.page10r),
                          color: CustomColors.lavender),
                    ),
                  ),
                  Align(
                    // container that contains the image
                    alignment: Alignment.center,
                    child: Container(
                      width: Dimension.innerpicturew,
                      height: Dimension.innerpictureh,
                      margin: EdgeInsets.only(top: Dimension.page10h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.page10r),
                        color: Colors.white,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("figures/girlimage1.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
