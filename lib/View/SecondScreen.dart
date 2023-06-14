// import 'dart:developer';
// import 'dart:html';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'MenuItems/Home.dart';
import '../Controller/auth_controller.dart';
// import 'NumberAuth.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController phoneController = TextEditingController();
  bool istrue = false;
// send otp function
  // void sendOTP() async {
  //   String phone = "+92" + phoneController.text.trim();
  //   log(phone);
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     codeSent: (verificationId, resendToken) {
  //       Navigator.push(
  //           context,
  //           CupertinoPageRoute(
  //               builder: ((context) => NumberAuth(
  //                     verificationId: verificationId,
  //                   ))));
  //     },
  //     verificationCompleted: (credential) {},
  //     verificationFailed: (ex) {
  //       log(ex.code.toString());
  //     },
  //     codeAutoRetrievalTimeout: (verifcationId) {},
  //     timeout: Duration(seconds: 30),
  //   );

  //   // if the verificationCompleted function does not get credential
  //   // for a specifc time this fucntion is fired
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          automaticallyImplyLeading: false,
          title: Text("   Quick ResQ"),
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            )
            // PopupMenuButton<String>(
            //   onSelected: (value) {
            //     // TODO: Handle menu item selection
            //   },
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

        // column
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                // COntainer of Text
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    "Quick ResQ will send an SMS message to verify your mobile number without any Carrier SMS charges. Enter your mobile number.",
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                // New Row to Add Number
                Row(
                  children: [
                    Container(
                      width: 50,
                      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: const TextField(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '+92',

                          // Placeholder text
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.fromLTRB(05, 20, 7, 20),

                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      // enter number text field

                      child: TextField(
                        maxLength: 10,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ie.  3096123777',
                          labelText: "Input Number",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        // onChanged: (text) {
                        //   // This function is called every time the user types or deletes a character in the text field
                        //   print(text);
                        // },
                      ),
                    ),
                    // elevated icon button
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthController().sendOTP(phoneController, context);
                    setState(() {
                      istrue = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.red,
                  ),
                  child: (istrue == false)
                      ? const Icon(Icons.arrow_forward, color: Colors.white)
                      : CircularProgressIndicator(
                          color: Colors.white,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
