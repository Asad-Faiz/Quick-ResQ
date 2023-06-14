import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/View/MenuItems/Home.dart';
import 'package:firstapp/View/NumberAuth.dart';
import 'package:firstapp/View/SecondScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../View/LandingPage.dart';
import '../View/addInfoScreen.dart';

class AuthController extends GetxController {
  String verifcationID = '';
  void sendOTP(
      TextEditingController phoneController, BuildContext context) async {
    String phone = "+92" + phoneController.text.trim();
    log(phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, resendToken) {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: ((context) => NumberAuth(
                      verificationId: verificationId,
                    ))));
      },
      verificationCompleted: (credential) {},
      verificationFailed: (ex) {
        log(ex.code.toString());
      },
      codeAutoRetrievalTimeout: (verifcationId) {},
      timeout: const Duration(seconds: 30),
    );

    // if the verificationCompleted function does not get credential
    // for a specifc time this fucntion is fired
  }

  // verify otp

  verifyOTP(TextEditingController otpController, context,
      String verificationId) async {
    String otp = otpController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        try {
          DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
              .get();

          if (documentSnapshot.exists) {
            // Document with specified ID exists
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          } else {
            // Document with specified ID does not exist
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AddInfoScreen()),
            );
          }
        } catch (e) {
          // Handle any potential errors
          print("Error: $e");
        }
      }
      // Navigator.push(context,
      //     CupertinoPageRoute(builder: ((context) => AddInfoScreen())));
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
  }

  // Logout
  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const LandingPage()));
  }

  requestPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Permissions required");
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => SecondScreen()));
    }
  }
}
