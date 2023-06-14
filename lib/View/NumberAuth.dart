import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Controller/auth_controller.dart';
import 'package:firstapp/View/SecondScreen.dart';
// import 'package:firstapp/View/MenuItems/Home.dart';
// import 'package:firstapp/View/SecondScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
// import 'package:sms_autofill/sms_autofill.dart';

// import 'addInfoScreen.dart';

class NumberAuth extends StatefulWidget {
  final String verificationId;
  const NumberAuth({super.key, required this.verificationId});

  @override
  State<NumberAuth> createState() => _NumberAuthState();
}

class _NumberAuthState extends State<NumberAuth> {
  bool istrue = false;
  TextEditingController otpController = TextEditingController();
  // verifyOTP() async {
  //   String otp = otpController.text.trim();
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: widget.verificationId, smsCode: otp);
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     if (userCredential.user != null) {
  //       try {
  //         DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
  //             .get();

  //         if (documentSnapshot.exists) {
  //           // Document with specified ID exists
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => Home()),
  //           );
  //         } else {
  //           // Document with specified ID does not exist
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => AddInfoScreen()),
  //           );
  //         }
  //       } catch (e) {
  //         // Handle any potential errors
  //         print("Error: $e");
  //       }
  //     }
  //     // Navigator.push(context,
  //     //     CupertinoPageRoute(builder: ((context) => AddInfoScreen())));
  //   } on FirebaseAuthException catch (ex) {
  //     log(ex.code.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    log(otpController.text);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        title: const Center(child: Text("Verify +92 XXX XXXXXX")),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
          )
          // PopupMenuButton<String>(
          //   onSelected: (value) {},
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //     const PopupMenuItem<String>(
          //       value: 'Restart',
          //       child: Text('Restart App'),
          //     ),
          //   ],
          //   child: Container(
          //       margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          //       child: const Icon(Icons.more_vert)),
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // ignore: prefer_const_constructors
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Wrap(
                direction: Axis.horizontal,
                children: [
                  const Text(
                    "We have sent you a SMS with a code to the number +92 XXX XXXXXX. It can take up to few seconds, thank you for your patience. ",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SecondScreen()));
                        },
                        child: const Center(
                            child: Text(
                          "Wrong Number?",
                          style: TextStyle(fontSize: 20),
                        )),
                      )),
                  const Center(
                      child: Text(
                    "Enter 6 Digit code",
                    style: TextStyle(fontSize: 22),
                  )),
                  TextField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    maxLength: 6,
                    controller: otpController,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: Container(
                      // margin: EdgeInsets.only(left: 120),
                      // margin:EdgeInsets.only(left: MediaQuery.of(context).size.width*),
                      child: SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              backgroundColor: Colors.red),
                          child: (istrue == false)
                              ? Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 20),
                                )
                              : CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         AddInfoScreen()));
                            AuthController().verifyOTP(
                                otpController, context, widget.verificationId);
                            setState(() {
                              istrue = true;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
