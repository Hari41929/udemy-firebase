import 'package:flutter/material.dart';
import 'package:udemy/chatapp/credentials/login.dart';
import 'package:udemy/chatapp/credentials/signup.dart';
import 'package:udemy/chatapp/welcome.dart';
import 'package:udemy/chatapp/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyAxJC77Bow_3xzaD1ah3bGVqibDwQ_SgHs", appId: "1:207554624147:android:ce7c589ebd9d5c9d9b6b66", messagingSenderId: "207554624147", projectId: "chat-45cb0"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/log":(context) => MyLoginPage(),
        "/signup": (context) => SignUp(),
        "/chatScreen": (context) => ChatScreen(),
      },
    );
  }
}
