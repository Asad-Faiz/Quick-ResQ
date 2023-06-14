// import 'dart:convert';
// import 'dart:developer';

import 'package:firstapp/Controller/emergency_Reqest_Controller.dart';
import 'package:firstapp/Model/Emergency_request_mode.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widget/custom_drawer.dart';
// import 'Home.dart';
// import 'Emergency.dart';
// import 'ExploreScreen.dart';
// import 'About.dart';
// import 'FISLitrature.dart';
// import 'Feed.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final EmergencyController request = EmergencyController();
  List<EmergencyRequestModel> requestList = [];
  bool isLoading = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmergencyRequests();
  }

  void openMaps(double lan, double lon) async {
    var latitude = lan;
    var longitude = lon;

    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps';
    }
  }

  Future<void> getEmergencyRequests() async {
    requestList = await request.ShowEmergencyAllRequests();

    setState(() {});
  }
// getAddressFromLatLng(context, double lat, double lng) async {
//     String _host = 'https://maps.google.com/maps/api/geocode/json';
//     final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
//     if(lat != null && lng != null){
//       var response = await get(Uri.parse(url));
//       if(response.statusCode == 200) {
//         Map data = jsonDecode(response.body);
//         String _formattedAddress = data["results"][0]["formatted_address"];
//         print("response ==== $_formattedAddress");
//         return _formattedAddress;
//       } else return null;
//     } else return null;
//   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
            child: CustomDrawer(),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.red,
            title: const Column(
              // ignore: prefer_const_literals_to_create_immutables
              // children: [
              //   Center(child: Text("Punjab Emergencies Services")),
              //   Center(
              //       child: Text(
              //     "   RESCUE 1122",
              //     style: TextStyle(color: Color(0xffFFF500), fontSize: 24),
              //   )),
              // ],
              children: [
                Center(child: Text("Emergency Feed")),
              ],
            ),
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
          body: (requestList.isEmpty || isLoading)
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.red,
                ))
              : RefreshIndicator.adaptive(
                  color: Colors.red,
                  onRefresh: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await getEmergencyRequests();
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: ListView.builder(
                    itemCount: requestList.length,
                    itemBuilder: (context, index) {
                      var emergenyRequest = requestList[index];
                      return Column(
                        children: [
                          Container(
                            height: 300,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.12,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.12,
                                          child: Image.network(
                                            emergenyRequest.dpurl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   child: CircleAvatar(
                                      //     child: Image.network(
                                      //       emergenyRequest.dpurl,
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(emergenyRequest.name),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            openMaps(emergenyRequest.lan,
                                                emergenyRequest.lon);
                                          },
                                          icon: const Icon(Icons.location_on)),
                                    ],
                                  ),
                                ),
                                (requestList.isEmpty)
                                    ? const CircularProgressIndicator(
                                        color: Colors.red,
                                      )
                                    : Image.network(
                                        emergenyRequest.emergencyurl,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      ),
                                Padding(
                                  padding: EdgeInsets.all(8).copyWith(top: 4),
                                  child: Column(
                                    children: [
                                      Text(
                                        emergenyRequest.fullAddress,
                                        maxLines: 2,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      );
                    },
                  ),
                )),
    );
  }
}
