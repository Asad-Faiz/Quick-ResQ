import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../LandingPage.dart';
import '../MenuItems/About.dart';
import '../MenuItems/Emergency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../MenuItems/FISLitrature.dart';
import '../MenuItems/Feed.dart';
import '../MenuItems/Home.dart';
import '../MenuItems/Explore.dart';
// import '../SecondScreen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String name = '';
  String cnic = '';
  String url = '';
  String? number = FirebaseAuth.instance.currentUser!.phoneNumber;
  initState() {
    super.initState();
    getData(number);
  }

  Future<void> getData(String? documentId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          // log(data.toString());
          setState(() {
            name = data['name'];
            cnic = data['cnic'];
            url = data['imageurl'];
          });
        }

        // Access specific fields using data['field_name']
      } else {
        log("no data found");
        // Handle case when document does not exist
      }
    } catch (e) {
      // Handle any potential errors
    }
  }

  void Logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const LandingPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 58,
          width: double.infinity,
          color: Colors.red,
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            children: [
              (url.isEmpty)
                  ? const CircleAvatar(
                      child: const CircularProgressIndicator(
                        color: Colors.red,
                      ),
                      backgroundColor: Colors.white,
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(url),
                      // backgroundImage: AssetImage("assets/images/contact.png"),
                    ),
              const SizedBox(
                width: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "${name}",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text("${number}",
                        style: TextStyle(fontSize: 16, color: Colors.white))
                  ],
                ),
              )
            ],
          ),
        ),
        ListTile(
            onTap: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (BuildContext context) => Home()));
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                  context, CupertinoPageRoute(builder: (context) => Home()));
            },
            leading: const Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            title: const Text("Home")),
        ListTile(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => const Emergency()));
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => Emergency()));
            },
            leading: const FaIcon(
              // ignore: deprecated_member_use
              FontAwesomeIcons.ambulance,
              color: Colors.black,
            ),
            title: const Text("Request Status")),
        ListTile(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => ExploreScreen()));
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => ExploreScreen()));
            },
            leading: const Icon(
              Icons.feed_outlined,
              color: Colors.black,
            ),
            title: const Text("Emergency Feed")),
        ListTile(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => const FrstAid()));
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                  context, CupertinoPageRoute(builder: (context) => FrstAid()));
            },
            leading: const Icon(
              Icons.medical_services_outlined,
              color: Colors.black,
            ),
            title: const Text("First Aid literature")),
        ListTile(
            onTap: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (BuildContext context) => Feed()));
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                  context, CupertinoPageRoute(builder: (context) => Feed()));
            },
            leading: const Icon(
              Icons.feedback_outlined,
              color: Colors.black,
            ),
            title: const Text("Feedback")),
        ListTile(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => About()));
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                  context, CupertinoPageRoute(builder: (context) => About()));
            },
            leading: const Icon(
              Icons.info,
              color: Colors.black,
            ),
            title: const Text("About")),
        Spacer(),
        Container(
            // height: 260,
            // height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Logout(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    border:
                        Border.all(color: Color.fromARGB(255, 218, 216, 216))),
                // margin: EdgeInsets.only(
                //   top: 180,
                // ),
                padding: EdgeInsets.only(left: 20),
                // height: 50,
                height: 50,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "LOGOUT",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
