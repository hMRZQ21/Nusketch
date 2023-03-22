import 'package:flutter/material.dart';

class ArtPage extends StatefulWidget{
  ArtPage({super.key });
  @override
  State<ArtPage> createState() => _ArtPage();
}

class _ArtPage extends State<ArtPage>{
  bool _canSee = true;

  void hideWidget() {
    setState(() {
      _canSee = !_canSee;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            AnimatedOpacity(
              opacity: _canSee? 1.0 : 0.0,
              duration:  const Duration(milliseconds: 500),
              child: Row(
                children: [
                  ElevatedButton(onPressed: (){}, child: Icon(Icons.add)),
                  ElevatedButton(onPressed: (){}, child: Icon(Icons.add)),
                  ElevatedButton(onPressed: (){}, child: Icon(Icons.add)),
                ],
              ),
            ),

            ElevatedButton(onPressed: (){hideWidget();}, child: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }

}