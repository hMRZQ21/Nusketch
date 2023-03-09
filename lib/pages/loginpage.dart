import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:nusketch/pages/signuppage.dart';

import 'mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{

  @override
  Widget build(BuildContext context){
    //todo: when landscape mode make view scrollable or resize / layout
    return
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white10,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Row(
                      children: [
                        const Image(image:AssetImage("figures/Title_P1.png")),
                        Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: const Image(image:AssetImage("figures/Title_Spin.png"))
                        ),
                        const Image(image:AssetImage("figures/Title_P2.png")),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border:OutlineInputBorder(),
                        labelText: 'Username',
                        hintText: "Enter your amazing username",
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top:20.0),
                    child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border:OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: "Enter your secure password",
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.zero,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                              'Forgot Password?',
                              textAlign: TextAlign.right,
                          ),
                          onPressed: () {
                            debugPrint("forgot password button pressed");
                          },
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    // constraints: const BoxConstraints(minWidth: double.infinity),
                    child: ElevatedButton(
                        onPressed: (){
                          debugPrint("Login button clicked");
                        },
                        child: const Text("Sign in")
                    ),
                  ),

                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),

                  Column(

                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "or",
                            style: TextStyle(
                                color: Colors.white,
                            ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: SignInButton(
                            Buttons.GoogleDark,
                            text: "Sign in with Google",
                            onPressed: () {
                              // todo: link to firebase
                              debugPrint("Login w/ google button clicked");
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),

                        child: SizedBox(
                          width: double.infinity,
                          child: SignInButtonBuilder(
                            text: 'Sign in with Email',
                            icon: Icons.email,
                            onPressed: () {
                              // todo: link to firebase
                              debugPrint("Login w/ email button clicked");
                            },
                            backgroundColor: Colors.blueGrey[700]!,
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const SignupPage()),
                                );
                              },
                              child: const Text("Sign Up"),
                          ),
                        ],
                      ),
                    ],
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const MainPage(),)
                      );
                    },
                    child: const Text(
                        "Skip"
                    ),
                  ),
                ],
              ),
            ),
          ),
      );
  }
}
