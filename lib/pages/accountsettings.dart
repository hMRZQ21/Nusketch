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
            margin: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      child: Icon(Icons.email),
                    ),
                    Container(
                      width: 80,
                      height: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: const Text("Email"),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 300,
                  height: 100,
                  padding: const EdgeInsets.only(top: 20),
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
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      child: Icon(Icons.phone),
                    ),
                    Container(
                      width: 80,
                      height: 20,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Phone"),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 300,
                  height: 100,
                  padding: const EdgeInsets.only(top: 20, left: 10),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      child: Icon(Icons.calendar_month),
                    ),
                    Container(
                      width: 80,
                      height: 20,
                      margin: EdgeInsets.only(),
                      child: Align(
                        alignment: Alignment.center,
                        child: const Text("Birthday"),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    final DateTime? update = await showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 300,
                          margin: EdgeInsets.only(bottom: 90),
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
                    width: 300,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "${selectedDate.month}  ${selectedDate.day}, ${selectedDate.year}"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      child: Icon(Icons.account_circle),
                    ),
                    Container(
                      width: 80,
                      height: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: const Text("Gender"),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 310,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                        ),
                      ),
                    ),
                    child: DropdownButton<String>(
                      underline: Container(),
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
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(top: 20, right: 20),
              width: 90,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  'Save',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
