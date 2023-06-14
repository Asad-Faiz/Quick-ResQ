import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../Locationscreen.dart';
import '../widget/custom_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(
          child: CustomDrawer(),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          title: const Column(
            // ignore: prefer_const_literals_to_create_immutables
            // children: [
            //   Center(
            //       child: Text(
            //     "Punjab Emergencies Services",
            //     style: TextStyle(fontSize: 15),
            //   )),
            //   Center(
            //       child: Text(
            //     "   RESCUE 1122",
            //     style: TextStyle(color: Color(0xffFFF500), fontSize: 24),
            //   )),
            // ],
            children: [
              Center(
                child: Text(
                  "Quick ResQ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
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

        // appbar ends here
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(width * 0.02, 0, width * 0.02, 0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(width * 0.05),
                    child: const Text(
                      'Select type of Emergency',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Locationscreen(
                                        emergencyType: "Medical Emergency")));
                          },
                          child: Types("assets/images/first-aid-kit.png",
                              "Medical", width, height, context)),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Locationscreen(
                                      emergencyType: "Road Accident",
                                    )));
                          },
                          child: Types("assets/images/accident.png", "Accident",
                              width, height, context)),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Locationscreen(
                                        emergencyType: "Fire Emergency")));
                          },
                          child: Types("assets/images/fire.png", "Fire", width,
                              height, context)),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Locationscreen(
                                        emergencyType: "other Emergency")));
                          },
                          child: Types("assets/images/logo1.png", "Other",
                              width, height, context)),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_amber,
                        size: 32,
                        color: Colors.red,
                      ),
                      Text(
                        "Warning",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.red),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    width: 300,
                    child: const Center(
                      child: Text(
                        "Six months imprisonment for false reporting or fake calls",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Container Types(String img, String data, width, height, context) {
  return Container(
    width: width * 0.4,
    // height: height * 0.25,
    height: height * 0.25,
    // margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
    decoration: BoxDecoration(
      color: Color(0xffF3E7E7),
      border: Border.all(
        color: Color(0xffFF0000), // Border color
        width: 2, // Border width
      ),
      borderRadius: BorderRadius.circular(10), // Rounded corners
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(img, height: MediaQuery.of(context).size.height * 0.14),
        // Image.asset("assets/images/first-aid-kit.png"),
        const SizedBox(
          height: 10,
        ),
        Text(
          data,
          style: const TextStyle(fontSize: 22),
        )
      ],
    ),
  );
}
