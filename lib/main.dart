import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/View/LandingPage.dart';
import 'package:firstapp/View/MenuItems/Home.dart';
// import 'package:firstapp/View/addInfoScreen.dart';
// import 'package:firstapp/View/SecondScreen.dart';
// import 'package:firstapp/View/addInfoScreen.dart';
import 'package:flutter/material.dart';
// import 'View/LandingPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      // home: const LandingPage());
      home:
          (FirebaseAuth.instance.currentUser != null) ? Home() : LandingPage(),
    );

    // secondScreen() WHere we enter our number
    // NUmberAuth Where Otp comes
  }
}
