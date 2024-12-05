import 'package:flutter/material.dart';
import 'package:punjab_tourism/utils.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DialogPlayVideo extends StatefulWidget {
  String id;
  String thumb;
  String title;

  DialogPlayVideo(this.id, this.thumb, this.title, {super.key});

  @override
  State<DialogPlayVideo> createState() => _DialogPlayVideoState();
}

class _DialogPlayVideoState extends State<DialogPlayVideo> {
  var playing = false;
  var loading = true;
  YoutubePlayerController? controller = null;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController.fromVideoId(
      videoId: widget.id,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    laoding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          height: screenWidth,
          child: Stack(
            children: [
              YoutubePlayer(
                aspectRatio: 1.1,
                controller: controller!,
              ),
              playing
                  ? SizedBox()
                  : Positioned.fill(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: screenWidth,
                        child: Image.network(
                          widget.thumb,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned.fill(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                playing = true;
                              });
                              controller!.playVideo();
                            },
                            icon: Icon(Icons.play_circle, size: 80)),
                      )
                    ],
                  )),
              !loading
                  ? SizedBox()
                  : SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> laoding() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      loading = false;
    });
  }
}
