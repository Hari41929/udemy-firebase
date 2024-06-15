import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'styleConst.dart';
import 'package:udemy/chatapp/credentials/signup.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          child: Stack(
            children: [
              Positioned(
                bottom: 200,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1.7,
                  child: Image.asset("assets/Backgrounds/Spline.png"),
                ),
              ),
              RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
              Positioned.fill(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: const SizedBox())),
              SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "FlashChat",
                      style: kTitleText,
                    ),
                    const Text(
                      "Messaging apps now have more global users than traditional social networks—which means they will play an increasingly important role in the distribution of digital journalism in the future.",
                      style: fancyText,
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/log");
                      },
                      child: const SizedBox(
                        height: 63,
                        width: 265,
                        child: Stack(
                          children: [
                            RiveAnimation.asset(
                              "assets/RiveAssets/button.riv",
                            ),
                            Positioned.fill(
                                top: 8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_right),
                                    Text(
                                      "Login",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: const SizedBox(
                        height: 63,
                        width: 265,
                        child: Stack(
                          children: [
                            RiveAnimation.asset(
                              "assets/RiveAssets/button.riv",
                            ),
                            Positioned.fill(
                                top: 8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_right),
                                    Text(
                                      "Sign Up",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
