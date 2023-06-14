import 'package:firstapp/Controller/emergency_Reqest_Controller.dart';
import 'package:firstapp/Model/Emergency_request_mode.dart';
import 'package:flutter/material.dart';
import '../widget/custom_drawer.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  final EmergencyController request = EmergencyController();
  List<EmergencyRequestModel> requestList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmergencyRequests();
  }

  getEmergencyRequests() async {
    requestList = await request.ShowEmergencyRequests();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    EmergencyController().ShowEmergencyRequests();
    return SafeArea(
      child: Scaffold(
          drawer: const Drawer(
            child: CustomDrawer(),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.red,
            title: const Center(child: Text("Request Status")),
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
          body: (requestList.isEmpty)
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.red,
                ))
              : ListView.builder(
                  itemCount: requestList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      // title: Text(requestList[index].name),
                      title: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: (requestList.isNotEmpty)
                                        ? CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              requestList[index].dpurl,
                                            ),
                                            // backgroundImage: NetworkImage(
                                            //   requestList[index].dpurl,
                                            // ),
                                          )
                                        : CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                                // Image.network(
                                //   requestList[index].dpurl,
                                // ),
                              ],
                            ),
                            // --------------------------------
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  child: Container(
                                    child: const Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("Type : "),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text("Time : "),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text("Status : "),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // ----------------------------------
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(requestList[index]
                                                .EmergencyType),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(requestList[index]
                                                .date
                                                .split(".")[0]),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            (requestList[index].Status ==
                                                    'pending')
                                                ? Text(
                                                    "Pending",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : (requestList[index].Status ==
                                                        'arriving')
                                                    ? Text(
                                                        "On The Way",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    : Text(
                                                        "Patient At Hospital",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // ----------------------------------
                          ],
                        ),
                      ),
                      // subtitle: Text(requestList[index].date.split(".")[0]),
                      // leading: Text(requestList[index].EmergencyType),
                    );
                  },
                )),
    );
  }
}
