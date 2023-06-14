import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Model/Feedback_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/MenuItems/Home.dart';

class FeedbackController extends GetxController {
  sendfeedback(
      TextEditingController feedbackController, BuildContext context) async {
    String? number = FirebaseAuth.instance.currentUser!.phoneNumber;
    DocumentSnapshot sourceSnapshot = await FirebaseFirestore.instance
        // .collection('users').doc(FirebaseAuth.instance.currentUser)
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .get();
    if (sourceSnapshot.exists) {
      Map<String, dynamic> userData =
          sourceSnapshot.data() as Map<String, dynamic>;

      final feedback = Feedback_Model(
          dpurl: userData['imageurl'],
          number: number!,
          name: userData['name'],
          cnic: userData['cnic'],
          date: DateTime.now().toString(),
          feedback: feedbackController.text.trim());

      final res = await FirebaseFirestore.instance
          .collection("UserFeedback")
          // .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .add(feedback.toMap())
          .then((value) => {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Feedback Submited'),
                      content: Text('Feedback Sent'),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Home()));
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                )
              });
      //   .then(
      // (value) async {
      //   showAlertDialog(context);
      log(res.toString());

      // },
      // );
    }
  }
}
