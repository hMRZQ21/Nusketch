import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/foldersketches.dart';
import 'package:nusketch/util/colors.dart';
import 'package:nusketch/util/dimension.dart';

class PortfoliosPage extends StatefulWidget {
  const PortfoliosPage({super.key});

  @override
  State<PortfoliosPage> createState() => _PortfoliosPageState();
}

class _PortfoliosPageState extends State<PortfoliosPage> {
  TextEditingController newFolderName = TextEditingController();
  final List<String> folders = [
    "My Flowers",
    "Folder 2",
    "Folder 3",
    "Folder 4",
    "Folder 5",
    "John Doe",
  ]; // placeholder for input array from database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.lightBlue,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("New Folder"),
                              actions: <Widget>[
                                TextField(
                                  controller: newFolderName,
                                  decoration: InputDecoration(
                                    hintText: "Enter new folder name",
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (newFolderName.text.isEmpty) {
                                              //TODO: empty show error message
                                            } else {
                                              folders.add(newFolderName.text);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar((SnackBar(
                                                      content: Container(
                                                          child: Text(
                                                              "New folder created: " +
                                                                  newFolderName
                                                                      .text)))));
                                            }
                                          });
                                          newFolderName.clear();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Confirm"),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ))
                  })
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            runSpacing: 5,
            spacing: MediaQuery.of(context).size.shortestSide * .08,
            children: List.generate(folders.length, (index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => FolderView(
                                folder: folders[index], folderIndex: index)),
                      );
                    },
                    child: Icon(
                      Icons.folder,
                      size: MediaQuery.of(context).size.shortestSide * .4,
                      color: CustomColors.lightBlue,
                    ),
                  ),
                  Text(folders[index]),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       color: Colors.grey.shade100,
  //       child: ListView.builder(
  //         itemBuilder: (context, index) {
  //           int fitem = index * 2;
  //           int sitem = fitem + 1;
  //           if (folders.length % 2 == 1) {
  //             if (sitem < folders.length) {
  //               return Row(
  //                 children: [
  //                   agencyColumn(fitem),
  //                   agencyColumn(sitem),
  //                 ],
  //               );
  //             } else {
  //               return Row(
  //                 children: [
  //                   agencyColumn(fitem),
  //                 ],
  //               );
  //             }
  //           } else {
  //             return Row(
  //               children: [
  //                 agencyColumn(fitem),
  //                 agencyColumn(sitem),
  //               ],
  //             );
  //           }
  //         },
  //         itemCount: (folders.length + 1) ~/ 2,
  //         scrollDirection: Axis.vertical,
  //       ),
  //     ),
  //   );
  // }
  //
  // Column agencyColumn(int index) {
  //   return Column(
  //     children: [
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             CupertinoPageRoute(
  //                 builder: (context) => FolderView(folder: folders[index])),
  //           );
  //         },
  //         child: Container(
  //           width: Dimension.screenWidth / 2,
  //           height: Dimension.page180h,
  //           child: Container(
  //             margin: EdgeInsets.only(top: Dimension.page35h),
  //             child: Icon(
  //               Icons.folder,
  //               size: Dimension.size170,
  //               color: Colors.blue.shade200,
  //             ),
  //           ),
  //         ),
  //       ),
  //       Container(
  //         width: Dimension.screenWidth / 2,
  //         height: Dimension.page30h,
  //         child: Center(
  //           child: Text(
  //             folders[index],
  //             style: TextStyle(fontSize: Dimension.size18),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
