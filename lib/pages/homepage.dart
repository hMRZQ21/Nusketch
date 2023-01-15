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


import 'package:flutter/material.dart';
import 'package:nusketch/pages/description.dart';
import 'package:nusketch/util/colors.dart';
import 'package:nusketch/util/dimension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold (
      //The app bar is the top portion of the homepage
      appBar: AppBar (
        //Appbar is set up like this -> [leading]  [title]  [actions]
        backgroundColor: Colors.transparent,
        elevation: 0, //This gets rid of the shadow after setting the background color of the appbar to transparent
        actions:[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
            color: Colors.blue,
          ),
        ],
      ),

      //Body contains all the images 
      body: Container(
      // sizing depends on size of the elements it contains, should be made dynamic later
      height: 2700,
      child: ListView.builder(
        // getting rid of NeverScrollableScrollPhysics because we only want the container to be scrollable.
        // NeverScrollableScrollPhysics makes scrolling the whole screen possible instead of the container only scrollable
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 490,
            margin: EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
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
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DescriptionPage()),
                          );
                        },
                        child: Container(
                          width: Dimension.innerpicturew,
                          height: Dimension.innerpictureh,
                          margin: EdgeInsets.only(top: Dimension.page10h),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.page10r),
                            color: Colors.white,
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("figures/girlimage1.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ),
    );
  }
}