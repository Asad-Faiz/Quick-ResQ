import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widget/custom_drawer.dart';

class FrstAid extends StatefulWidget {
  const FrstAid({super.key});

  @override
  State<FrstAid> createState() => _FrstAidState();
}

class _FrstAidState extends State<FrstAid> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        title: const Center(child: Text("First Aid Literature")),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('videos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }

          List<VideoData> videoDataList = snapshot.data!.docs.map((doc) {
            String videoTitle = doc['videoTitle'];
            String videoUrl = doc['videoUrl'];
            YoutubePlayerController controller = YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
              flags: YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            );
            return VideoData(videoTitle, controller);
          }).toList();

          return ListView.builder(
            itemCount: videoDataList.length,
            itemBuilder: (context, index) {
              VideoData videoData = videoDataList[index];
              return Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoData.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    YoutubePlayer(
                      controller: videoData.controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      progressColors: ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VideoData {
  final String title;
  final YoutubePlayerController controller;

  VideoData(this.title, this.controller);
}
