import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/folderview.dart';
import 'package:nusketch/util/dimension.dart';

class PortfoliosPage extends StatefulWidget {
  const PortfoliosPage({super.key});

  @override
  State<PortfoliosPage> createState() => _PortfoliosPageState();
}

class _PortfoliosPageState extends State<PortfoliosPage> {
  final List<String> folders = [
    "Folder 1",
    "Folder 2",
    "Folder 3",
    "Folder 4",
    "Folder 5",
    "Folder 6",
    "Folder 7",
    "Folder 8",
    "Folder 9",
  ]; // placeholder for input array from database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
        child: ListView.builder(
          itemBuilder: (context, index) {
            int fitem = index * 2;
            int sitem = fitem + 1;
            if (folders.length % 2 == 1) {
              if (sitem < folders.length) {
                return Row(
                  children: [
                    agencyColumn(fitem),
                    agencyColumn(sitem),
                  ],
                );
              } else {
                return Row(
                  children: [
                    agencyColumn(fitem),
                  ],
                );
              }
            } else {
              return Row(
                children: [
                  agencyColumn(fitem),
                  agencyColumn(sitem),
                ],
              );
            }
          },
          itemCount: (folders.length + 1) ~/ 2,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

  Column agencyColumn(int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => FolderView(folder: folders[index])),
            );
          },
          child: Container(
            width: Dimension.screenWidth / 2,
            height: Dimension.page180h,
            child: Container(
              margin: EdgeInsets.only(top: Dimension.page35h),
              child: Icon(
                Icons.folder,
                size: Dimension.size170,
                color: Colors.blue.shade200,
              ),
            ),
          ),
        ),
        Container(
          width: Dimension.screenWidth / 2,
          height: Dimension.page30h,
          child: Center(
            child: Text(
              folders[index],
              style: TextStyle(fontSize: Dimension.size18),
            ),
          ),
        ),
      ],
    );
  }
}
