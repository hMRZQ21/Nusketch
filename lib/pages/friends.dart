import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<String> _friendsList = [];
  bool _isButtonClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: ListView.builder(
        itemCount: _friendsList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _showShareSelectorDialog();
            },
            child: ListTile(
              title: Text(_friendsList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFriendDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showShareSelectorDialog() async {
    bool _isChecked = true;
    bool _isChecked2 = false;
    bool _isButtonClicked = false; // declare local variable here
    bool _isButtonClicked2 = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // wrap the AlertDialog with StatefulBuilder
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Share'),
              content: Container(
                height: 300,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 200,
                            width: 100,
                            child: Image(
                              image: AssetImage(
                                  "figures/2023-4-21_11-41-34_completed.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              // use setState from StatefulBuilder
                              _isButtonClicked = !_isButtonClicked;
                            });
                          },
                          child: Material(
                            color: _isButtonClicked ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              child: Container(
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 200,
                            width: 100,
                            child: Image(
                              image: AssetImage(
                                  "figures/2023-4-21_11-42-20_completed.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              // use setState from StatefulBuilder
                              _isButtonClicked2 = !_isButtonClicked2;
                            });
                          },
                          child: Material(
                            color:
                                _isButtonClicked2 ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              child: Container(
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Confirm'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddFriendDialog() {
    String _email = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Friends'),
          content: TextField(
            onChanged: (value) {
              _email = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter friend\'s email',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _friendsList.add(_email);
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
