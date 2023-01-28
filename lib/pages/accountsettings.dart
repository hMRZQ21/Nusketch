import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  late String _gender;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _gender = 'Prefer not to say';
  }

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
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Not valid Email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  ),
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
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Phone"),
                  ),
                ),
                Container(
                  width: 290,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                    ),
                  ),
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
                  padding: const EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    value: _gender,
                    items: ['Male', 'Female', 'Other', 'Prefer not to say']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String? update) {
                      setState(() {
                        _gender = update!;
                      });
                    },
                  ),
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
                GestureDetector(
                  onTap: () async {
                    final DateTime? update = await showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 300,
                          margin: EdgeInsets.only(bottom: 100),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            maximumYear: DateTime.now().year,
                            onDateTimeChanged: (DateTime update) {
                              setState(
                                () {
                                  selectedDate = update;
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 290,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                          "${selectedDate.month}  ${selectedDate.day}, ${selectedDate.year}"),
                    ),
                  ),
                ),
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
