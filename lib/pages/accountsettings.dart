import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mainpage.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 50,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text("Email"),
                  ),
                ),
                Container(
                  width: 290,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 50,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text("Phone"),
                  ),
                ),
                Container(
                  width: 290,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 50,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text("Gender"),
                  ),
                ),
                Container(
                  width: 290,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your gender',
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 50,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text("Birthday"),
                  ),
                ),
                Container(
                  width: 290,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your birthday',
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 90,
            height: 30,
            decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                'Save',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
