import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:nusketch/util/dimension.dart';

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
            margin: EdgeInsets.only(top: Dimension.page50h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      child: const Icon(Icons.email),
                    ),
                    Container(
                      width: Dimension.page80w,
                      height: Dimension.page20h,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Email"),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: Dimension.page300w,
                  height: Dimension.page100h,
                  padding: EdgeInsets.only(top: Dimension.page20h),
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
            margin: EdgeInsets.only(left: Dimension.page10w),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      child: Icon(Icons.phone),
                    ),
                    Container(
                      width: Dimension.page80w,
                      height: Dimension.page20h,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Phone"),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: Dimension.page300w,
                  height: Dimension.page100h,
                  padding: EdgeInsets.only(
                      top: Dimension.page20h, left: Dimension.page10w),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Enter your phone number',
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Dimension.page20h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      child: const Icon(Icons.calendar_month),
                    ),
                    Container(
                      width: Dimension.page80w,
                      height: Dimension.page20h,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Birthday"),
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
                          height: Dimension.page300h,
                          margin: EdgeInsets.only(bottom: Dimension.page90h),
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
                    width: Dimension.page300w,
                    height: Dimension.page20h,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: Dimension.page1w,
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
            margin: EdgeInsets.only(
                top: Dimension.page20h, left: Dimension.page10w),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      child: const Icon(Icons.account_circle),
                    ),
                    Container(
                      width: Dimension.page80w,
                      height: Dimension.page20h,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Gender"),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: Dimension.page310w,
                  height: Dimension.page50h,
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: Dimension.page1w,
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
                          child: Text(value),
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
              margin: EdgeInsets.only(
                  top: Dimension.page20h, right: Dimension.page20w),
              width: Dimension.page90w,
              height: Dimension.page50h,
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(Dimension.page20r)),
              child: const Center(
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
