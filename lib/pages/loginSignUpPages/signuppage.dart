import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nusketch/auth/auth.dart';
import '../mainpage.dart';
import 'loginpage.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});
  final User? user = Auth().currentUser;
  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          errorMessage = ('The password provided is too weak.');
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          errorMessage = ('The account already exists for that email.');
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white10,
      body: Center(
        // When keyboard is open
        child: SingleChildScrollView(
          //Allows one widget to be scrollable
          physics:
              BouncingScrollPhysics(), // bounces content back to place when keyboard is closed
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  child: Row(
                    children: [
                      const Image(image: AssetImage("figures/Title_P1.png")),
                      Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: const Image(
                              image: AssetImage("figures/Title_Spin.png"))),
                      const Image(image: AssetImage("figures/Title_P2.png")),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: _controllerEmail,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Example@email.com',
                      hintText: "Enter your amazing email",
                    ),
                  ),
                ),

                // const Padding(
                //   padding: EdgeInsets.only(top:20.0),
                //   child: TextField(
                //     decoration: InputDecoration(
                //       filled: true,
                //       fillColor: Colors.white,
                //       border:OutlineInputBorder(),
                //       labelText: 'Username',
                //       hintText: "Enter your amazing username",
                //     ),
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: _controllerPassword,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: "Enter your secure password",
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    // constraints: const BoxConstraints(minWidth: double.infinity),
                    child: ElevatedButton(
                        onPressed: () {
                          debugPrint("Sign Up button clicked");
                          createUserWithEmailAndPassword();
                        },
                        child: const Text("Sign up")),
                  ),
                ),

                const Divider(
                  color: Colors.white,
                  thickness: 1,
                ),

                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
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
                            // TODO: link to firebase
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
                            // TODO: link to firebase
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ));
                      },
                      child: const Text("Skip"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
