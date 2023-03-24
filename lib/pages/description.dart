import 'package:flutter/material.dart';
import 'package:nusketch/pages/homepage.dart';
import 'package:nusketch/util/colors.dart';
import 'package:nusketch/util/flip.dart';

import '../util/dimension.dart';

class DescriptionPage extends StatefulWidget {
  DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.beige2,
        actions: [],
      ),
      backgroundColor:
          CustomColors.mainColor, // uses colors.dart to set custom colors
      body: Center(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  children: [
                    Text(
                      'date',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Monday October 24, 2022',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Align(
                  // container that contains the image
                  alignment: Alignment.center,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width *
                              0.01), // blue padding around image
                      child: FlipAround()),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(top: Dimension.page30h),
                      child: const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                        "In non tincidunt justo. Duis sit amet ante turpis. Aliquam pulvinar "
                        "elementum orci, id malesuada felis luctus id. Etiam sed dolor lorem. "
                        "Sed venenatis leo justo, non pellentesque velit mattis sit amet. Proin "
                        "venenatis quis libero eget semper. Integer in neque erat. Donec ultricies"
                        " nisl nunc, nec venenatis ligula accumsan in. Vivamus at varius nunc. "
                        "Vestibulum quam turpis, fringilla in velit vitae, tincidunt sodales leo."
                        " Vestibulum eget mi sit amet risus tempus suscipit."
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Vestibulum "
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Vestibulum "
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Vestibulum "
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Vestibulum "
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Vestibulum "
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Vestibulum "
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Vestibulum "
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Vestibulum eget mi sit amet risus tempus suscipit",
                        overflow: TextOverflow.fade,
                      ),
                    ),
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
