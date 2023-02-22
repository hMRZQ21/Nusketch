import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nusketch/pages/agencyview.dart';
import 'package:nusketch/util/dimension.dart';

class PortfoliosPage extends StatefulWidget {
  const PortfoliosPage({super.key});

  @override
  State<PortfoliosPage> createState() => _PortfoliosPageState();
}

class _PortfoliosPageState extends State<PortfoliosPage> {
  final List<String> agencies = [
    "Agency 1",
    "Agency 2",
    "Agency 3",
    "Agency 4",
    "Agency 5",
    "Agency 6",
    "Agency 7",
    "Agency 8",
    "Agency 9",
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
            if (agencies.length % 2 == 1) {
              if (sitem < agencies.length) {
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
          itemCount: (agencies.length + 1) ~/ 2,
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
                  builder: (context) => AgencyView(agency: agencies[index])),
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
              agencies[index],
              style: TextStyle(fontSize: Dimension.size18),
            ),
          ),
        ),
      ],
    );
  }
}
