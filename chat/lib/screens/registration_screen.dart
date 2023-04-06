// ignore_for_file: avoid_print, unused_import
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../buttons/Input_Button.dart';
import '../buttons/Buttom_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const id = 'registration-screen';

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

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
                  controller: emailController,
                  hinttext: 'Enter Your Email',
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InputButton(
                  onchange: () {},
                  chose: true,
                  controller: passwordController,
                  hinttext: 'Enter Your Password',
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
                          await _auth.createUserWithEmailAndPassword(
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
                  card: const Text('Register'),
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
