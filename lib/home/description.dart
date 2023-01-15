import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nusketch/home/heading.dart';
import 'package:nusketch/util/colors.dart';

import '../util/dimension.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          CustomColors.mainpagebgcolor, // uses colors.dart to set custom colors
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.blue, size: 55),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimension.page20h,
                  left: Dimension.page30w,
                  bottom: Dimension.page10h),
              child: const Text(
                'Sketch of a girl',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
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
                      borderRadius: BorderRadius.circular(Dimension.page10r),
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
          Align(
            alignment: Alignment.center,
            child: Container(
              width: Dimension.outtercontainerw,
              height: Dimension.outtercontainerh,
              child: const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In non tincidunt justo. Duis sit amet ante turpis. Aliquam pulvinar elementum orci, id malesuada felis luctus id. Etiam sed dolor lorem. Sed venenatis leo justo, non pellentesque velit mattis sit amet. Proin venenatis quis libero eget semper. Integer in neque erat. Donec ultricies nisl nunc, nec venenatis ligula accumsan in. Vivamus at varius nunc. Vestibulum quam turpis, fringilla in velit vitae, tincidunt sodales leo. Vestibulum eget mi sit amet risus tempus suscipit."),
            ),
          ),
        ],
      ),
    );
  }
}
