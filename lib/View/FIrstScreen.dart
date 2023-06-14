// import 'package:firstapp/SecondScreen.dart';
// import 'dart:developer';

import 'package:firstapp/Controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
// import 'package:geolocator/geolocator.dart';

// import 'MenuItems/Home.dart';
import 'SecondScreen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:permission_handler/permission_handler.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // requestPermission() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied ||
  //       permission == LocationPermission.deniedForever) {
  //     log("Permissions required");
  //     LocationPermission asked = await Geolocator.requestPermission();
  //   } else {
  //     Navigator.popUntil(context, (route) => route.isFirst);
  //     Navigator.pushReplacement(
  //         context, CupertinoPageRoute(builder: (context) => SecondScreen()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/tick.png"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                child: Text(
                    "In Order To work properly, Quick ResQ needs location  permission.",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
              ),
              Container(
                height: 56,
                width: 342,
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 26, 25, 25),
                          title: Text(
                            'Premission Required',
                            style: TextStyle(color: Colors.white, fontSize: 21),
                          ),
                          content: Text(
                            'This app may not work properly without the requested permissions. Open the app settings screen to modify app permissions.',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                            TextButton(
                              onPressed: () {
                                AuthController().requestPermission(context);
                                // _requestPermissions();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SecondScreen()));
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("OK"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE42B2B)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
