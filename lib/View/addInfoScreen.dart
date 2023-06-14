// import 'dart:js';

import 'dart:developer';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/Controller/auth_controller.dart';
import 'package:firstapp/Controller/send_user_controller.dart';
// import 'package:firstapp/View/LandingPage.dart';
// import 'package:firstapp/View/MenuItems/Home.dart';
// import 'package:firstapp/View/SecondScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import '../Model/user_model.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({super.key});

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  File? profilepic;
  bool istrue = false;

  // void logout(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.popUntil(context, (route) => route.isFirst);
  //   Navigator.pushReplacement(
  //       context, CupertinoPageRoute(builder: (context) => const LandingPage()));
  // }

// collecting image

  Future<void> _showPickerDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      log("image selected");
      File convertedfile = File(pickedImage.path);
      setState(() {
        profilepic = convertedfile;
      });
    } else {
      log("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: const Center(child: Text("Profile")),
        actions: [
          IconButton(
              onPressed: () {
                AuthController().logout(context);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(100, 20, 100, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 120.0,
                    backgroundColor: Colors.blue,
                    backgroundImage:
                        (profilepic != null) ? FileImage(profilepic!) : null,
                  ),
                  // backgroundImage: AssetImage("assets/images/profile.png"),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CupertinoButton(
                      onPressed: () {
                        _showPickerDialog();
                      },
                      child: const CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.red,
                        child:
                            Icon(Icons.camera_alt_rounded, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  // suffixIcon: IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.edit,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: cnicController,
                decoration: const InputDecoration(
                  hintText: 'Cnic No',
                  // suffixIcon: IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.edit,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.5,
                    // margin: const EdgeInsets.all(30),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: (istrue == false)
                            ? const Text("Update")
                            : CircularProgressIndicator(
                                color: Colors.white,
                              ),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) => Home()));
                          UserController().saveUser(profilepic, nameController,
                              cnicController, context);
                          setState(() {
                            istrue = true;
                          });
                          ;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
            // collumn
          ),
        ),
      ),
    ));
  }
}
