import 'package:firstapp/View/FIrstScreen.dart';
// import 'package:firstapp/View/SecondScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'FIrstScreen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/images/splash.png",
                fit: BoxFit.contain,
              )),
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) => FirstScreen()));
            // Navigator.of(context).push(MaterialPageRoute(

            //     builder: (BuildContext context) => SecondScreen()));
          },
        ),
      ),
    );
  }
}
