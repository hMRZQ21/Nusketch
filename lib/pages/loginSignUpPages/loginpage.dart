import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:nusketch/pages/loginSignUpPages/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nusketch/auth/auth.dart';
import '/util/colors.dart';
import '../mainpage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  final User? user = Auth().currentUser;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          errorMessage = ('No user found for that email.');
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorMessage = ('Wrong password provided for that user.');
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: when landscape mode make view scrollable or resize / layout
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        // For keyboard opened:
        child: SingleChildScrollView(
          // its a box that allows a single widget to be scrolled
          physics:
              BouncingScrollPhysics(), // this allows the content to go outside the bounds of the phone but then bounce back once keyboard is gone
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
                      labelText: 'Email',
                      hintText: "Enter your amazing email",
                    ),
                  ),
                ),
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
                        style: TextStyle(
                          color: Colors.purple
                        ),
                      ),
                      onPressed: () {
                        debugPrint("forgot password button pressed");
                        signInWithEmailAndPassword();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  // constraints: const BoxConstraints(minWidth: double.infinity),
                  child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Login button clicked");
                        signInWithEmailAndPassword();
                      },
                      child: const Text("Sign in")),
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
                            // TODO: link to firebase
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
                            // TODO: link to firebase
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()),
                            );
                          },
                          child: const Text("Sign Up", style: TextStyle(
                              color: Colors.purple
                          ),),
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ));
                  },
                  child: const Text("Skip",
                    style: TextStyle(
                      color: Colors.purple
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
