// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../Buttons/Input_Button.dart';
import '../Buttons/buttom_Button.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const id = 'login-screen';

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
            body: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Flexible(
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            height: 200.0,
                            child: Image.asset('images/logo.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      InputButton(
                        onchange: () {},
                        hinttext: 'Enter Your Email',
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      InputButton(
                        onchange: () {},
                        hinttext: 'Enter Your Password',
                        controller: passwordController,
                        chose: true,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      ButtomButton(
                        onpress: () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            final newUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
            
                            // ignore: unnecessary_null_comparison
                            if (newUser != null) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                          } catch (e) {
                            print(e);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        card: const Text('Log In'),
                        color: Colors.lightBlueAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
