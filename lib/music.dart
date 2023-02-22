import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:kokosai_74_app/appbar_options.dart';
import 'package:video_player/video_player.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);


  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  late final VideoPlayerController _videoPlayerController;
  late final ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    fetchVideo();
  }

  Future<void> fetchVideo() async {
    _videoPlayerController = VideoPlayerController.network('http://app74.kokosai.jp/theme-song/theme_song_mv.mp4');
    _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(context, 'テーマソング再生'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Center(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ),
    );
  }
}