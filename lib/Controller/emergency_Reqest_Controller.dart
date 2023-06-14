import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'dart:js';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/Model/Emergency_request_mode.dart';
import 'package:firstapp/View/widget/custom_Alert_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class EmergencyController extends GetxController {
  // function to get current position
  void getCurrentPosition(
      File? profilepic, String emergencyType, BuildContext context) async {
    double? lon;
    double? lat;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Permissions required");
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      lon = currentPosition.longitude;
      lat = currentPosition.latitude;

      log(currentPosition.toString());
      // print(object)
    }
    final fullAddress = await getAddressFromLatLng(context, lat!, lon!);
    print(fullAddress);
    processData(
      lon,
      lat,
      profilepic,
      emergencyType,
      fullAddress,
      context,
    );
  }

// AIzaSyBrb9htKhdbcKZd9yYAxjWelinqHQI_uEo
  getAddressFromLatLng(context, double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url =
        '$_host?key=AIzaSyBrb9htKhdbcKZd9yYAxjWelinqHQI_uEo&language=en&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else
        return null;
    } else
      return null;
  }

  Future<void> processData(double longitude, double latitude, File? profilepic,
      String emergencyType, String fullAddress, BuildContext context) async {
    // getting then saving photo with userdata map
    String? number = FirebaseAuth.instance.currentUser!.phoneNumber;
    UploadTask uploadtask = FirebaseStorage.instance
        .ref("EmergencyPhotos")
        .child(number!)
        .child(Uuid().v4())
        .putData(await profilepic!.readAsBytes());
    TaskSnapshot taskSnapshot = await uploadtask;
    String downloadurl = await taskSnapshot.ref.getDownloadURL();
    DocumentSnapshot sourceSnapshot = await FirebaseFirestore.instance
        // .collection('users').doc(FirebaseAuth.instance.currentUser)
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .get();
    if (sourceSnapshot.exists) {
      Map<String, dynamic> userData =
          sourceSnapshot.data() as Map<String, dynamic>;
      // userData['latitude'] = latitude;
      // userData['longitude'] = longitude;
      // userData['EmergencyPhoto'] = downloadurl;

      // emergency model
      final emergencyRequest = EmergencyRequestModel(
          lan: latitude,
          lon: longitude,
          fullAddress: fullAddress,
          emergencyurl: downloadurl,
          dpurl: userData['imageurl'],
          number: number,
          name: userData['name'],
          cnic: userData['cnic'],
          date: DateTime.now().toString(),
          EmergencyType: emergencyType,
          Status: "pending");

      final res = await FirebaseFirestore.instance
          .collection("EmergencyRequest")
          // .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .add(emergencyRequest.toMap())
          .then(
        (value) async {
          showAlertDialog(context);
          // final Uri url = Uri(
          //   scheme: 'tel',
          //   path: '1122',
          // );
          // if (await canLaunchUrl(url)) {
          //   await launchUrl(url);
          // } else {
          //   log("cannot open url");
          // }
        },
      );
      // log(emergencyRequest.toString());
      // log(res.);
      // if (res. != null) {}
    }
    // log(sourceSnapshot.docs.toString());
  }

// getting and isplaying data in Emergency Screen
  ShowEmergencyRequests() async {
    QuerySnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection("EmergencyRequest")
            .where("number",
                isEqualTo:
                    FirebaseAuth.instance.currentUser!.phoneNumber.toString())
            .orderBy("date", descending: true)
            .get();
    // log(documentSnapshot.docs[0].data().toString());
    List<EmergencyRequestModel> requests = [];
    documentSnapshot.docs.forEach((element) {
      // print(element.data()!["longitude"].runtimeType);
      requests.add(EmergencyRequestModel.fromMap(
          element.data() as Map<String, dynamic>));
    });
    return requests;
  }

  ShowEmergencyAllRequests() async {
    QuerySnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection("EmergencyRequest")
            .orderBy("date", descending: true)
            .get();
    // log(documentSnapshot.docs[0].data().toString());
    List<EmergencyRequestModel> requests = [];
    documentSnapshot.docs.forEach((element) {
      // print(element.data()!["longitude"].runtimeType);
      requests.add(EmergencyRequestModel.fromMap(
          element.data() as Map<String, dynamic>));
    });
    return requests;
  }
}
