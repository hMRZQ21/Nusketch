import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PortfoliosPage extends StatefulWidget {
  const PortfoliosPage({super.key});

  @override
  State<PortfoliosPage> createState() => _PortfoliosPageState();
}

class _PortfoliosPageState extends State<PortfoliosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Icon(
                CupertinoIcons.folder_fill,
                size: 100,
                color: Colors.blue.shade200,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Icon(
                CupertinoIcons.folder_fill,
                size: 100,
                color: Colors.blue.shade200,
              ),
            ),
          ],
        )
      ],
    ));
  }
}
