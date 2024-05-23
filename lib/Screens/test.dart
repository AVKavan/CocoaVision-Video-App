import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  ChewieController? _chewieController;

  Future<void> _initializeVideoPlayer() async {
    final storage = FirebaseStorage.instance;
    final reference = storage.ref().child('outputfile.mp4'); // Replace with your video path
    final url = await reference.getDownloadURL();
    print(url);


    final videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController.initialize();

    print('HI');

    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, error) => Center(child: Text(error)),
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: _chewieController != null
          ? Chewie(controller: _chewieController!,)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
