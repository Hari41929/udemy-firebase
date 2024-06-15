import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemy/chatapp/styleConst.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  bool _showSpinner = false;
  late String email;
  late String paswrd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 25,
                          width: 80,
                          height: 200,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/light-1.png"),
                              ),
                            ),
                          )),
                      Positioned(
                          top: 30,
                          left: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color.fromRGBO(143, 148, 251, 1),
                              size: 30.0,
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 150,
                          width: 80,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/light-2.png")),
                            ),
                          )),
                      Positioned(
                          top: 150,
                          right: 40,
                          width: 100,
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/clock.png"))),
                          )),
                      Positioned(
                          child: Center(
                        child: Text(
                          "Sign Up",
                          style: hloginPageTitle,
                        ),
                      ))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, 0.3),
                                    offset: Offset(0, 10),
                                    blurRadius: 20.0),
                              ]),
                          child: Column(
                            children: [
                              TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Your Email",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 20)),
                              ),
                              Divider(),

                              // SizedBox(height: 30,),
                              TextField(
                                onChanged: (value) {
                                  paswrd = value;
                                },
                                style: TextStyle(fontSize: 20),
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 20)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            try {
                              setState(() {
                                _showSpinner = true;
                              });
                              final userData =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: paswrd);

                              if (userData != null) {
                                Navigator.pushNamed(context, "/chatScreen");
                              }
                              setState(() {
                                _showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .8),
                                  Color.fromRGBO(143, 148, 251, .6),
                                  Color.fromRGBO(143, 148, 251, .4),
                                  Color.fromRGBO(143, 148, 251, .2)
                                ])),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
