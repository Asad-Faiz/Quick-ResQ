import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/View/MenuItems/Home.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../Model/user_model.dart';

class UserController {
  // save user data
  void saveUser(File? profilepic, TextEditingController nameController,
      TextEditingController cnicController, BuildContext context) async {
    String name = nameController.text.trim();
    String cnicNo = cnicController.text.trim();
    String? number = FirebaseAuth.instance.currentUser!.phoneNumber;

    // saving picture
    UploadTask uploadtask = FirebaseStorage.instance
        .ref("ProfilePics")
        .child(number!)
        .putData(await profilepic!.readAsBytes());
    TaskSnapshot taskSnapshot = await uploadtask;
    String downloadurl = await taskSnapshot.ref.getDownloadURL();

    if (name != '' || cnicNo != '') {
      // Map<String, dynamic> UserData = {
      //   "name": name,
      //   "cnic": cnicNo,
      //   "dp": downloadurl,
      //   "number": FirebaseAuth.instance.currentUser!.phoneNumber,
      // };
      final user = myUser(
          cnic: cnicNo, imageurl: downloadurl, name: name, number: number);

      // create class instance
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .set(user.toMap());
      log("user Added");
      nameController.clear();
      cnicController.clear();

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => Home()));
    } else {
      log("Please Fill all Fields");
    }
  }
}
