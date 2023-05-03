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

class ImageInformation {
  final String title;

  const ImageInformation(this.title);
}

//TODO: fix landscape mode
class _HomePageState extends State<HomePage> {
  List imageList = [
    "figures/bird.jpg",
    "figures/building.jpg",
    "figures/eye.jpg",
    "figures/portrait.jpg",
    "figures/girlimage1.png",
  ];

  List name=[
    "THE bird",
    "My dog Ruff",
    "Eyes are the soul",
    "My Beautiful Wife",
    "Disney Character",
  ];

  List date=[
    "May 1st, 2023",
    "April 16th, 2023",
    "Mar 12th, 2023",
    "Jan 4th, 2023",
    "Oct 20th, 2022",
  ];

  List description= [
  "The sketch depicts a small bird with a plump body and a round head. Its beak is short and pointed, and its eyes are large and bright. The bird's features are outlined in black ink, with varying line thicknesses to create depth and texture. The artist has focused on capturing the bird's proportions and unique features, such as the shape of its beak and the position of its wings. The bird is perched on a branch, with its feet curled around the wood and its wings slightly spread out as if in mid-flight. Although the sketch lacks color, the artist has succeeded in conveying the bird's character and movement through the careful use of lines and shading.",
"The sketch depicts a loyal and friendly dog with a wagging tail. Its breed is not specified, but it has a medium-sized body and floppy ears that hang low. The dog's eyes are large and expressive, conveying a sense of warmth and curiosity. The artist has used pencil strokes to create texture in the dog's fur, with careful attention to the contours of its face and body. The dog is depicted in a sitting position, with its tongue out and a big grin on its face, as if eagerly awaiting attention or a treat. Overall, the sketch captures the essence of a faithful companion, bringing joy and happiness to all those around it.",
    "The sketch depicts a detailed and realistic eye, with intricate shading and texture. The artist has used pencil strokes to create a sense of depth and dimension, with highlights and shadows giving the impression of light reflecting off the surface of the eye. The iris is a rich and vibrant color, with subtle variations in hue and tone that add to the realism of the image. The pupil is round and dark, with a glint of light catching its surface. The eyelashes and surrounding skin are also carefully rendered, with each strand and wrinkle lending a sense of authenticity to the image. Overall, the sketch captures the beauty and complexity of the human eye, with its many intricate details and subtle variations.",
    "features and a serene expression. The artist has used pencil strokes to create a sense of texture and depth in the woman's hair and clothing, with flowing lines that suggest movement and fluidity. Her eyes are almond-shaped and expressive, conveying a sense of wisdom and introspection. The woman's lips are full and slightly curved, with a hint of a smile that suggests inner peace and contentment. The artist has paid careful attention to the proportions of the woman's face and body, creating a sense of balance and harmony in the composition. Overall, the sketch captures the timeless beauty and inner strength of the feminine form, celebrating the many qualities that make women so special and unique.",
  "The drawing depicts a cheerful and spirited girl with an infectious smile. Her features are soft and delicate, with large expressive eyes and a button nose. Her hair is styled in a classic Disney-like fashion, with loose waves and a colorful ribbon adorning her head. The artist has used bright and cheerful colors, with playful lines and swirls that evoke a sense of joy and wonder. The girl is surrounded by a cast of animal friends, each rendered in a charming and whimsical style. The scene is set in a pastoral landscape, with rolling hills and a bright blue sky that add to the sense of playfulness and whimsy. Overall, the drawing captures the innocence and charm of childhood, with a Disney-like flair that inspires the imagination and celebrates the joy of life.",
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1000) {
        // phone
        return phone();
      } else {
        return tablet(); // tablet
      }
    });
  }

  Widget phone() => Scaffold(
      backgroundColor: CustomColors.mainColor,
      body: Center(
        //Populate whole screen
        child: ListView.builder(
          // ListView list of children we want to create recursively
          itemCount: imageList
              .length, // Length of temp list -> will become the length of database
          itemBuilder: (context, index) {
            // Necessary to build the ListView
            return Container(
              // Were gonna return the container
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),

              // The space around the container
              // color: Colors.green, // [for testing ] Color to show container for text and image
              child: Column(
                // column to stack on top of each other
                children: [
                  //Top portion image title and date created
                  Align(
                    // align allows you to position child relative to parent
                    alignment: Alignment.topLeft, // align to top left
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const so children never change at compile time
                        Text(
                          name[index],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          date[index],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // image
                  Expanded(
                    // fills the rest of the column
                    child: Align(
                      alignment: Alignment.topLeft, // Aligns image to top left
                      child: InkWell(
                        onTap: () {

                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => DescriptionPage(imageList[index],date[index],name[index], description[index]),)
                          );
                        },
                        child: Container(
                          // Container of image
                          // decoration: BoxDecoration(
                          //     border: Border.all(),
                          //     color: CustomColors.beige2,
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(10.0))),
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width *
                                  0.03), // blue padding around image
                          // color: Colors.blue, // Color of padding
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              // inserting image
                              imageList[index], // Image at index x
                              fit: BoxFit
                                  .cover, // Cover the whole box with image
                              width: double
                                  .infinity, // fills container of image to full width of column
                            ),
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
      ));

  Widget tablet() => Scaffold(
          body: Center(
        //Populate whole screen
        child: ListView.builder(
          // ListView list of children we want to create recursively
          itemCount: imageList
              .length, // Length of temp list -> will become the length of database
          itemBuilder: (context, index) {
            // Necessary to build the ListView
            return Container(
              // Were gonna return the container
              height: MediaQuery.of(context).size.height * 0.9,
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              // The space around the container
              // color: Colors.green, // [for testing ] Color to show container for text and image
              child: Column(
                // column to stack on top of each other
                children: [
                  //Top portion image title and date created
                  Align(
                    // align allows you to position child relative to parent
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
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'date ${index}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // image
                  Expanded(
                    // fills the rest of the column
                    child: Align(
                      alignment: Alignment.topLeft, // Aligns image to top left
                      child: InkWell(
                        onTap: () {
                          debugPrint(
                              'image clicked \nimage: ${index} \ndate:${index}');
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => DescriptionPage(imageList[index],date[index],name[index], description[index])),
                          );
                        },
                        child: Container(
                          // Container of image
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03),
                          height: 2000, // blue padding around image
                          // color: Colors.blue, // Color of padding
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              // inserting image
                              imageList[index], // Image at index x
                              fit: BoxFit
                                  .cover, // Cover the whole box with image
                              width: double
                                  .infinity, // fills container of image to full width of column
                            ),
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
      ));
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
