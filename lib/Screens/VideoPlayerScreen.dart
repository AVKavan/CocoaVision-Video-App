import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class VideoPlayerScreen extends StatefulWidget {
  final File videoFile;

  const VideoPlayerScreen({Key? key, required this.videoFile}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile);
    print(_controller?.value);
    _controller?.initialize().then((_) {
      setState(() {});
    }).catchError((error) {
      print('Error initializing video: $error');
      // Handle video initialization errors (e.g., network or file issues)
    });

    _controller?.addListener(() {
      if (_controller?.value.errorDescription != null) {
        print('Error during playback: ${_controller?.value.errorDescription}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Processed Video'),
      ),
      body: Center(
        child: VideoPlayer(
          // Use video_player package for video playback
          // You may need to import 'package:video_player/video_player.dart'
          // And ensure you have added 'video_player: ^2.1.11' (or any compatible version) to your pubspec.yaml file
          // Adjust video player options as needed
          VideoPlayerController.file(widget.videoFile)..initialize(),
          // Add more options if needed
        ),
      ),
    );
  }
}


