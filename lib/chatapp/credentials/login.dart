import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemy/chatapp/styleConst.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _logauth = FirebaseAuth.instance;
  bool _isShowSpinner = false;
  late String eml;
  late String pswrd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isShowSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 500,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/lbg.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        child: Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width + 30,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/lbg2.png"),
                                  fit: BoxFit.fill)),
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
                            color: Color.fromRGBO(229, 229, 234, 1),
                            size: 30.0,
                          ),
                        )),
                  ],
                ),
              ),
              const Text(
                "Login",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(180, 97, 225, 0.7),
                              offset: Offset(0, 10),
                              blurRadius: 20,
                            )
                          ]),
                      child: Column(
                        children: [
                          TextField(
                              onChanged: (value) {
                                eml = value;
                              },
                              decoration: loginStyle),
                          Divider(),
                          TextField(
                            onChanged: (value) {
                              pswrd = value;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: "Password",
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 20)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          setState(() {
                            _isShowSpinner = true;
                          });
                          final suerStatus =
                              await _logauth.signInWithEmailAndPassword(
                                  email: eml, password: pswrd);

                          if (suerStatus != null) {
                            Navigator.pushNamed(context, "/chatScreen");
                          }
                          setState(() {
                            _isShowSpinner = false;
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
                              Color.fromRGBO(61, 43, 101, .8),
                              Color.fromRGBO(61, 43, 101, .6),
                              Color.fromRGBO(61, 43, 101, .4),
                              Color.fromRGBO(61, 43, 101, .2),
                            ])),
                        child: const Center(
                          child: Text(
                            "Login",
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
            ],
          ),
        ),
      ),
    );
  }
}
