import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          var pageWidth = constraints.maxWidth;
          var pageHeight = constraints.maxHeight;

          return Container(
            height: pageHeight,
            width: pageWidth,
            color: Colors.black,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return VideoPlayer(_controller);
                } else {
                  return Container(
                    color: Colors.black,
                    height: pageHeight,
                    width: pageWidth,
                  );
                }
              },
            ),
          );
        }));
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      "assets/images/SplashScreens/DashStudiosLogoSplash.webm",
      videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true, allowBackgroundPlayback: false),
    )..addListener(() {
        if (_controller.value.duration == _controller.value.position) {
          //Get.toNamed("/loading");
          Navigator.of(context).pushReplacementNamed("/loading");
        }
      });

    _initializeVideoPlayerFuture = _controller.initialize();
    //on video end go to next screen
    _initializeVideoPlayerFuture.then((value) => _controller.play());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
