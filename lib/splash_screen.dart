import 'package:flutter/material.dart';
import 'package:native_video_view/native_video_view.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: NativeVideoView(
          keepAspectRatio: true,
          showMediaController: false,
          onCreated: (controller) {
            controller.setVideoSource(
              'assets/splash/splash_movie_4.mp4',
              sourceType: VideoSourceType.asset
            );
          },
          onPrepared: (controller, info) {
            controller
              ..setVolume(0.0)
              ..play();
          },
          onCompletion: (controller) {
            controller.dispose();
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
      )
    );
  }
}