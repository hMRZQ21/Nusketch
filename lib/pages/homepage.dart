// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        body: Center(child: Text('body here')),
//        bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//             items: [
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
//               BottomNavigationBarItem(icon: Icon(Icons.camera_alt_rounded), label: 'camera'),
//               BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'upload'),
//             ],
//        ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/description.dart';
import 'package:nusketch/util/colors.dart';
import 'package:nusketch/util/dimension.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class ImageInformation{
  final String title;


  const ImageInformation(this.title);
}
class _HomePageState extends State<HomePage> {
  List imageList = [
      "figures/girlimage1.png",
      "figures/girlimage1.png",
      "figures/girlimage1.png",
      "figures/girlimage1.png",
      "figures/girlimage1.png",
];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center( //Populate whole screen
        child: ListView.builder( // ListView list of children we want to create recursively
          itemCount: imageList.length, // Length of temp list -> will become the length of database
          itemBuilder: (context,index) { // Necessary to build the ListView
            return Container( // Were gonna return the container
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.4,
              margin: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.1),
              // The space around the container
              // color: Colors.green, // [for testing ] Color to show container for text and image
              child: Column( // column to stack on top of each other
                children: [
                  Align( // align allows you to position child relative to parent
                    alignment: Alignment.topLeft, // align to top left
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const so children never change at compile time
                        Text(
                          'image ${index}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'date ${index}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded( // fills the rest of the column
                    child: Align(
                      alignment: Alignment.topLeft, // Aligns image to top left
                      child: InkWell(
                        onTap: () {
                          debugPrint(
                              'image clicked \nimage: ${index} \ndate:${index}');
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    DescriptionPage()
                            ),
                          );
                        },
                        child: Container( // Container of image
                          padding: EdgeInsets.all(MediaQuery
                              .of(context)
                              .size
                              .width * 0.03), // blue padding around image
                          color: Colors.blue, // Color of padding
                          child: Image.asset( // inserting image
                            imageList[index], // Image at index x
                            fit: BoxFit.cover, // Cover the whole box with image
                            width: double
                                .infinity, // fills container of image to full width of column
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      )
    );
  }
}


//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: ListView.builder(
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             return Container(
//               height: Dimension.page490h,
//               margin: EdgeInsets.only(bottom: Dimension.page30h),
//               decoration: BoxDecoration(
//                   color: Colors.blue.shade200,
//                   borderRadius: BorderRadius.circular(Dimension.page20r)),
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           top: Dimension.page20h,
//                           left: Dimension.page30w,
//                           bottom: Dimension.page10h),
//                       child: const Text(
//                         'Sketch of a girl',
//                         style: TextStyle(
//                             fontSize: 35, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           left: Dimension.page30w, bottom: Dimension.page10h),
//                       child: const Text(
//                         'Monday October 24, 2022',
//                         style: TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                   Stack(
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: Container(
//                           width: Dimension.outtercontainerw,
//                           height: Dimension.outtercontainerh,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.circular(Dimension.page10r),
//                               color: CustomColors.lavender),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               CupertinoPageRoute(
//                                   builder: (context) =>
//                                       const DescriptionPage()),
//                             );
//                           },
//                           child: Container(
//                             width: Dimension.innerpicturew,
//                             height: Dimension.innerpictureh,
//                             margin: EdgeInsets.only(top: Dimension.page10h),
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.circular(Dimension.page10r),
//                               color: Colors.white,
//                               image: const DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage("figures/girlimage1.png"),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
