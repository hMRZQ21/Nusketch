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
  @override
  void initState(){
    super.initState();
    emailController.addListener(() {setState(() { });});
  }

  bool isPasswordVisible = false;
  bool editable = false;
  DateTime selectedDate = DateTime.now();
  String email ="";

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Stack(
                children: [
                  //clip rounded rect -> round courners
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      child: Image.asset("figures/ProfilePlaceHolder.jpg"),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.blue),
                      child: IconButton(
                        onPressed:(){

                        },
                        icon: Icon(Icons.camera_enhance, size: 30,),

                      ),
                    ),
                  ),
                ],
              ),

              Form( //makes saving, updating, and editing easier
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  Form.of(primaryFocus!.context!).save();
                },
                child: Column(
                  children: [
                    buildName(),
                    buildEmail(),
                    buildPhone(),
                    buildPassword(),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            if(!_formKey.currentState!.validate()){
                              return;
                            }
                            _formKey.currentState!.save();
                            setState(() {
                              if(editable) editable = !editable;
                            });
                            }
                          ,
                          child: Text("save")
                      ),

                      ElevatedButton(
                          onPressed: (){
                            setState(() {
                              if(!editable) editable = !editable;
                            });
                          }
                          ,
                          child: Text("edit")
                      ),

                    ],
                  ),

                  ].map((widget) => Padding(padding: const EdgeInsets.all(10), child:widget)).toList(),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmail() => TextFormField(
    enabled: editable,
    controller: emailController,
    decoration: InputDecoration(
      // filled: true,
      // fillColor: Colors.orangeAccent.withOpacity(0.8),
      // hintStyle: TextStyle(color: Colors.black),
      // labelStyle: TextStyle(color: Colors.black),
      // iconColor: Colors.black,
      suffixStyle: TextStyle(color: Colors.black),
      border: const OutlineInputBorder(
        borderRadius:BorderRadius.all(Radius.circular(20.0)),
      ),
      prefixIcon: Icon(Icons.email),
      suffixIcon: emailController.text.isEmpty
          ?Container(width: 0,)
          :IconButton(icon:Icon(Icons.close),
            onPressed: () {
              emailController.clear();
            },
      ),
      hintText: "Enter your email?",
      labelText: "Email",
    ),
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.done,
    onSaved: (value){
      if(value != null) email = value;
    },
  );


  Widget buildName() => TextFormField(
    enabled: editable,
    controller: nameController,
    decoration: InputDecoration(
      fillColor: Colors.orangeAccent,
      border: const OutlineInputBorder(
        borderRadius:BorderRadius.all(Radius.circular(20.0)),
      ),
      prefixIcon: Icon(Icons.person),
      suffixIcon: nameController.text.isEmpty
          ?Container(width: 0,)
          :IconButton(icon:Icon(Icons.close),
        onPressed: () {
          nameController.clear();
        },
      ),
      hintText: "Enter your wonderful name?",
      labelText: "Name",
    ),
    textInputAction: TextInputAction.done,
    onSaved: (value){
      if(value != null) email = value;
    },
  );


  Widget buildPhone() => TextFormField(
    enabled: editable,
    controller: phoneController,
    decoration: InputDecoration(
      fillColor: Colors.orangeAccent,
      border: const OutlineInputBorder(
        borderRadius:BorderRadius.all(Radius.circular(20.0)),
      ),
      prefixIcon: Icon(Icons.phone),
      suffixIcon: phoneController.text.isEmpty
          ?Container(width: 0,)
          :IconButton(icon:Icon(Icons.close),
        onPressed: () {
          phoneController.clear();
        },
      ),
      hintText: "Enter your phone number?",
      labelText: "xxx-xxx-xxx",
    ),
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.done,
    onSaved: (value){
      if(value != null) email = value;
    },
  );

  Widget buildPassword() => TextFormField(
    enabled: editable,
    controller: passController,
    obscureText: isPasswordVisible,
    decoration: InputDecoration(
      hintText: "Enter your amazing password",
      labelText: "Password",
      errorText: "Incorrect password",
      prefixIcon: Icon(Icons.lock),
      suffixIcon: IconButton(
        icon: isPasswordVisible
            ? Icon(Icons.visibility_off)
            : Icon(Icons.visibility),
        onPressed: () { setState(() {
          isPasswordVisible = !isPasswordVisible;
        }); },
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    ),
  );



}


//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: Dimension.page50h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       child: const Icon(Icons.email),
//                     ),
//                     Container(
//                       width: Dimension.page80w,
//                       height: Dimension.page20h,
//                       child: const Align(
//                         alignment: Alignment.center,
//                         child: Text("Email"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   width: Dimension.page300w,
//                   height: Dimension.page100h,
//                   padding: EdgeInsets.only(top: Dimension.page20h),
//                   child: TextFormField(
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Required';
//                       }
//                       if (!EmailValidator.validate(value)) {
//                         return 'Not valid Email';
//                       }
//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your email',
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: Dimension.page10w),
//             child: Row(
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       child: Icon(Icons.phone),
//                     ),
//                     Container(
//                       width: Dimension.page80w,
//                       height: Dimension.page20h,
//                       child: const Align(
//                         alignment: Alignment.center,
//                         child: Text("Phone"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   width: Dimension.page300w,
//                   height: Dimension.page100h,
//                   padding: EdgeInsets.only(
//                       top: Dimension.page20h, left: Dimension.page10w),
//                   child: TextFormField(
//                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                     keyboardType: TextInputType.phone,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your phone number',
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: Dimension.page20h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       child: const Icon(Icons.calendar_month),
//                     ),
//                     Container(
//                       width: Dimension.page80w,
//                       height: Dimension.page20h,
//                       child: const Align(
//                         alignment: Alignment.center,
//                         child: Text("Birthday"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     final DateTime? update = await showCupertinoModalPopup(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Container(
//                           height: Dimension.page300h,
//                           margin: EdgeInsets.only(bottom: Dimension.page90h),
//                           child: CupertinoDatePicker(
//                             mode: CupertinoDatePickerMode.date,
//                             initialDateTime: DateTime.now(),
//                             maximumYear: DateTime.now().year,
//                             onDateTimeChanged: (DateTime update) {
//                               setState(
//                                 () {
//                                   selectedDate = update;
//                                 },
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     width: Dimension.page300w,
//                     height: Dimension.page20h,
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Colors.grey,
//                           width: Dimension.page1w,
//                         ),
//                       ),
//                     ),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                           "${selectedDate.month}  ${selectedDate.day}, ${selectedDate.year}"),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(
//                 top: Dimension.page20h, left: Dimension.page10w),
//             child: Row(
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       child: const Icon(Icons.account_circle),
//                     ),
//                     Container(
//                       width: Dimension.page80w,
//                       height: Dimension.page20h,
//                       child: const Align(
//                         alignment: Alignment.center,
//                         child: Text("Gender"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   width: Dimension.page310w,
//                   height: Dimension.page50h,
//                   padding: const EdgeInsets.all(10),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           width: Dimension.page1w,
//                         ),
//                       ),
//                     ),
//                     child: DropdownButton<String>(
//                       underline: Container(),
//                       value: _gender,
//                       items: ['Male', 'Female', 'Other', 'Prefer not to say']
//                           .map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? update) {
//                         setState(() {
//                           _gender = update!;
//                         });
//                       },
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Container(
//               margin: EdgeInsets.only(
//                   top: Dimension.page20h, right: Dimension.page20w),
//               width: Dimension.page90w,
//               height: Dimension.page50h,
//               decoration: BoxDecoration(
//                   color: Colors.blue.shade200,
//                   borderRadius: BorderRadius.circular(Dimension.page20r)),
//               child: const Center(
//                 child: Text(
//                   'Save',
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
