import 'package:flutter/material.dart';

import '../widget/custom_drawer.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(
          child: CustomDrawer(),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          title: const Center(child: Text("About")),
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
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(width * 0.09, 30, width * 0.09, 20),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo1.png"),
                  backgroundColor: Colors.white,
                  radius: 80,
                ),
                RichText(
                    textAlign: TextAlign.justify,
                    text: const TextSpan(
                      text:
                          'Welcome to Quick ResQ, your reliable companion in emergency situations. We understand the importance of acting swiftly and effectively during critical moments, and thats why we have developed this powerful smartphone application. Quick ResQ is designed to assist individuals and groups in accessing immediate help and vital resources when they need it the most \n\nWhether you are facing a car accident, a medical emergency, a fire, or any other unforeseen crisis, Quick ResQ is here to support you. Our user-friendly interface and intuitive features make it easy for anyone to navigate the app and get the help they need without any delays',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    )),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                    text:
                        '\nIf you have any other questions, feel free to call Customer Care on the following number and address:\n\n',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Helpline: 1122 \nEmail: quickResQ@gmail.com',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
