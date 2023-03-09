import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'loginpage.dart';
import 'mainpage.dart';

class SignupPage extends StatefulWidget{
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
                      labelText: 'Example@email.com',
                      hintText: "Enter your amazing email",
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
                  padding: const EdgeInsets.only(top:20.0, bottom:15.0),
                  child: SizedBox(
                    width: double.infinity,
                    // constraints: const BoxConstraints(minWidth: double.infinity),
                    child: ElevatedButton(
                        onPressed: (){
                          debugPrint("Login button clicked");
                        },
                        child: const Text("Sign up")
                    ),
                  ),
                ),

               const Divider(
                 color: Colors.white,
                 thickness: 1,
               ),

                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom:8.0, top:8.0),
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
                          text: "Sign up with Google",
                          onPressed: () {
                            // todo: link to firebase
                            debugPrint("Sign Up w/ google button clicked");
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),

                      child: SizedBox(
                        width: double.infinity,
                        child: SignInButtonBuilder(
                          text: 'Sign Up with Email',
                          icon: Icons.email,
                          onPressed: () {
                            // todo: link to firebase
                            debugPrint("Sign Up w/ email button clicked");
                          },
                          backgroundColor: Colors.blueGrey[700]!,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
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
                              context, MaterialPageRoute(builder: (context) => const LoginPage(),),
                            );
                          },
                          child: const Text("Sign In"),
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
                )
              ],
            ),
          ),
        ),
      );
  }
}