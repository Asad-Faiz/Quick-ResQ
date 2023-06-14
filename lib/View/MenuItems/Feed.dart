import 'package:firstapp/Controller/feedback_controller.dart';
import 'package:flutter/material.dart';
import '../widget/custom_drawer.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  TextEditingController feedbackController = TextEditingController();
  bool istrue = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(
          child: CustomDrawer(),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          title: const Center(child: Text("FeedBack")),
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            )
            //   PopupMenuButton<String>(
            //     onSelected: (value) {},
            //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            //       const PopupMenuItem<String>(
            //         value: 'Restart',
            //         child: Text('Restart App'),
            //       ),
            //     ],
            //     child: Container(
            //         margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            //         child: const Icon(Icons.more_vert)),
            //   )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.15,
                0,
                MediaQuery.of(context).size.width * 0.15,
                0),
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: feedbackController,
                    maxLines:
                        10, // Specify the desired number of lines for the TextField
                    decoration: InputDecoration(
                      // labelText: 'Enter your feedback',
                      hintText: "Type Here...",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: const Color.fromARGB(30, 158, 158, 158))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.red)),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  // Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Colors.red),
                            child: (istrue == false)
                                ? const Text(
                                    "Give FeedBack",
                                    style: TextStyle(fontSize: 20),
                                  )
                                : const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                            onPressed: () {
                              FeedbackController()
                                  .sendfeedback(feedbackController, context);
                              setState(() {
                                istrue = true;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // bottomSheet: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SizedBox(
        //       height: 60,
        //       width: 200,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //               shape: StadiumBorder(), backgroundColor: Colors.red),
        //           child: const Text(
        //             "Give FeedBack",
        //             style: TextStyle(fontSize: 20),
        //           ),
        //           onPressed: () {
        //             FeedbackController().sendfeedback(feedbackController);
        //           },
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
