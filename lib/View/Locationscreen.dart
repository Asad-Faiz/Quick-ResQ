import 'dart:developer';
import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/Controller/emergency_Reqest_Controller.dart';
import 'package:firstapp/View/widget/custom_drawer.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class Locationscreen extends StatefulWidget {
  Locationscreen({super.key, required this.emergencyType});
  String emergencyType;
  @override
  State<Locationscreen> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Locationscreen> {
  @override
  double lon = 0.0;
  double lat = 0.0;
  bool istrue = false;
// function to send data
  File? profilepic;
  // Future<void> _showPickerDialog() async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Select Image Source"),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: [
  //               GestureDetector(
  //                 child: Text("Gallery"),
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                   _pickImage(ImageSource.gallery);
  //                 },
  //               ),
  //               SizedBox(height: 10),
  //               GestureDetector(
  //                 child: Text("Camera"),
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                   _pickImage(ImageSource.camera);
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _pickImage() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
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

  // saving user

  // // function to get current position
  // void getCurrentPosition() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied ||
  //       permission == LocationPermission.deniedForever) {
  //     log("Permissions required");
  //     LocationPermission asked = await Geolocator.requestPermission();
  //   } else {
  //     Position currentPosition = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.best);
  //     setState(() {
  //       lon = currentPosition.longitude;
  //       lat = currentPosition.latitude;
  //     });

  //     log(currentPosition.toString());
  //   }
  //   processData(lon, lat);
  // }

  // Future<void> processData(double longitude, double latitude) async {
  //   // getting then saving photo with userdata map
  //   String? number = FirebaseAuth.instance.currentUser!.phoneNumber;
  //   UploadTask uploadtask = FirebaseStorage.instance
  //       .ref("EmergencyPhotos")
  //       .child(number!)
  //       .putData(await profilepic!.readAsBytes());
  //   TaskSnapshot taskSnapshot = await uploadtask;
  //   String downloadurl = await taskSnapshot.ref.getDownloadURL();
  //   DocumentSnapshot sourceSnapshot = await FirebaseFirestore.instance
  //       // .collection('users').doc(FirebaseAuth.instance.currentUser)
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
  //       .get();
  //   if (sourceSnapshot.exists) {
  //     Map<String, dynamic> userData =
  //         sourceSnapshot.data() as Map<String, dynamic>;
  //     userData['latitude'] = latitude;
  //     userData['longitude'] = longitude;
  //     userData['EmergencyPhoto'] = downloadurl;
  //     await FirebaseFirestore.instance
  //         .collection("EmergencyRequest")
  //         .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
  //         .set(userData);
  //     log(userData.toString());
  //   }
  //   // log(sourceSnapshot.docs.toString());
  // }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        title: Center(child: Text("Send Location")),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // TODO: Handle menu item selection
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Restart',
                child: Text('Restart App'),
              ),
            ],
            child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: const Icon(Icons.more_vert)),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: (profilepic != null)
                ? Image.file(
                    profilepic!,
                    fit: BoxFit.cover,
                  )
                : Image.asset("assets/images/map.png",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width),
          ),
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "Step 1 : Click ",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.camera_alt),
            ],
          ),
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "Step 2 : Click ",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Location  ",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 70),
            child: Row(
              children: [
                Container(
                  height: 90,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Icon(
                      Icons.camera_alt,
                      size: 90,
                    ),
                    onPressed: () {
                      // send location button
                      _pickImage();
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: (istrue == false)
                        ? const Text(
                            "Location",
                            style: TextStyle(fontSize: 26),
                          )
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                    onPressed: () {
                      // send location button
                      EmergencyController().getCurrentPosition(
                          profilepic, widget.emergencyType, context);
                      setState(() {
                        istrue = true;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
          // Container(
          //   height: 70,
          //   width: 350,
          //   margin: EdgeInsets.all(30),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          //       child: Text(
          //         "Send Location",
          //         style: TextStyle(fontSize: 26),
          //       ),
          //       onPressed: () {
          //         // send location button
          //         getCurrentPosition();
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    ));
  }
}
