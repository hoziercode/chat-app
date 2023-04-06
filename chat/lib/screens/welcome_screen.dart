import 'package:animated_text_kit/animated_text_kit.dart';
import '../Screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../Buttons/formButton.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const String id = 'welcome-screen';

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    super.initState();
    controller.forward();
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    decoration: BoxDecoration(
                      color: animation.value,
                    ),
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 42.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      speed: const Duration(milliseconds: 300),
                    ),
                  ],
                  
                  totalRepeatCount: 7,
                  pause: const Duration(milliseconds: 300),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                )
                          ],
                        ),
            const SizedBox(
              height: 48.0,
            ),
            FormButton(
              cardChild: const Text('Log In'),
              colour: Colors.lightBlueAccent,
              onPress: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
             FormButton(
               cardChild: const Text('Register'),
              colour: Colors.blueAccent,
              onPress: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
             ),
            
          ],
        ),
      ),
    );
  }
}

