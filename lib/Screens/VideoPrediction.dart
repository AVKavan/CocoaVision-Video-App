import 'dart:convert';
import 'dart:io';
import 'package:cocoa_video_app/constants/constants.dart';
import 'package:cocoa_video_app/controller/TexttoSpeech.dart';
import 'package:cocoa_video_app/utils/SelectionButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class VideoUploadScreen extends StatefulWidget {
  const VideoUploadScreen({Key? key});

  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  VideoPlayerController? _controller;
  Set<String> classes = Set();
  String _classContent = '';
  PickedFile? _video;
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> _uploadAndProcessVideo(File videoFile) async {
    var requestvideo = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://b14d-106-51-8-242.ngrok-free.app/process_video'));
    requestvideo.files
        .add(await http.MultipartFile.fromPath('video_file', videoFile.path));

    var streamedResponse = await requestvideo.send();
    var responsevideo = await http.Response.fromStream(streamedResponse);

    if (responsevideo.statusCode == 200) {
    //   // Save the processed video to a temporary file
      Directory tempDir = await getTemporaryDirectory();
      print(tempDir.path);
      File processedVideoFile =
      File('${tempDir.path}/processed_video.mp4');
      await processedVideoFile.writeAsBytes(responsevideo.bodyBytes);

      // Initialize the video player
      _controller = VideoPlayerController.file(processedVideoFile);
      await _controller!.initialize();

      setState(() {});


    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://b14d-106-51-8-242.ngrok-free.app/predict_video/'), // Replace with your server IP
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        videoFile!.path,
      ),
    );


      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> data = jsonDecode(response.body);
          print(data);
          List<dynamic> blackpodCocoa = data['merged-project-2'];

          // // Extract the "class" field from each "predictions" element
          blackpodCocoa.forEach((element) {
            List<dynamic> predictions = element['predictions'];
            predictions.forEach((prediction) {
              String classValue = prediction['class'];
              if (classValue != null && classValue != "null") {
                classes.add(classValue);
              }
            }


            );
          });
             print(classes);
          if(classes.isEmpty)
            classes.add('HEALTHY');
             _loadClassContent();
          // Print the unique "class" values

        });
      }
      else {
        // Handle error
        print('Error: ${response.reasonPhrase}');
      }
    }

      // Refresh UI
      // setState(() {});
    // } else {
    //   // Handle error
    //   print('Failed to process video: ${response.statusCode}');
    // }
  }

  Future<void> synthesizeText(String s) async {
    final text = s;
    String name = 'kn-IN-Wavenet-A';
    final locale = await getLocale();
    String languageCode = locale.languageCode;
    String? countryCode = locale.countryCode;
    if(languageCode == 'te')
      name = 'te-IN-Standard-A';

    final lang = '$languageCode'+'_'+'$countryCode';
    final api = TextToSpeechAPI();
    final audioContent = await api.synthesizeText(text, name, lang);

    // final path = await getTemporaryDirectory();
    // final file = File('${path.path}/temp.mp3');
    // if (!await file.exists()) {
    final audioBytes = base64Decode(audioContent!);
    //   await file.writeAsBytes(audioBytes);
    // }
    await audioPlayer.play(BytesSource(audioBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF008080).withOpacity(0.9),
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text(
          Translate(context,"video_prediction"),
          style: TextStyle(
              color: Colors.white,
              fontSize: 19
          ),
          ),
            IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: () {
                _launchUrl();
              }
            ),

          ],
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cocoa_bg_img.jpg'),
              fit: BoxFit.cover,
              opacity: 0.6),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.sizeOf(context).height*0.06
                  ,
                  width: MediaQuery.sizeOf(context).width*0.94,
                  child: SelectionButton(
                    title: Translate(context,"gallery"),
                    onpressed: _getVideo,
                    icons: Icons.folder,
                  ),
                ),
                SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.01
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height*0.06,
                  width: MediaQuery.sizeOf(context).width*0.94,
                  child: SelectionButton(
                    title: Translate(context,"camera"),
                    onpressed: _clickVideo,
                    icons: Icons.camera,
                  ),
                ),
                if (_controller != null)
                  AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                 if(_video != null && _controller == null)
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CircularProgressIndicator(),
                       Text(
                         'Loading Video...',
                         style: TextStyle(
                             fontSize: 15,
                             color: Colors.black
                         ),
                       ),
                     ],
                   ),
                if (_controller != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_controller!.value.isPlaying) {
                              _controller!.pause();
                            } else {
                              _controller!.play();
                            }
                          });
                        },
                        icon: Icon(
                          _controller!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                      ),
                    ],
                  ),
                if(_video != null && classes.isEmpty && _controller != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        'Loading Pesticide...',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),

                if (classes.isNotEmpty) Container(

                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Set shadow color
                        spreadRadius: 5, // Set spread radius
                        blurRadius: 7, // Set blur radius
                        offset: Offset(0, 3), // Set offset for shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(Translate(context, 'verdict')+': ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.deepOrange.shade900),),
                        for (var classId in classes!)
                          Text(
                            Translate(context, '$classId')+',',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                          ),
                      ],
                    ),
                  ),
                ),
                if (_classContent.isNotEmpty)
                  SingleChildScrollView(
                    child: Container(
                      // height: MediaQuery.sizeOf(context).height,
                      // width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Set shadow color
                            spreadRadius: 5, // Set spread radius
                            blurRadius: 7, // Set blur radius
                            offset: Offset(0, 3), // Set offset for shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(11),
                        child: TextButton(
                          onPressed: () {
                            synthesizeText(Translate(context, 'solution')+': \n$_classContent');
                          },
                          child: Text(
                            Translate(context, 'solution')+': \n$_classContent',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 19
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadClassContent() async {
    // Assuming your .txt files are in the 'assets' folder
    for (var classId in classes!) {
      print(classId);
      if(classId == 'HEALTHY') continue;
      final locale = await getLocale();
      String languageCode = locale.languageCode;
      final classContent = await DefaultAssetBundle.of(context).loadString('assets/recommendation_text/$classId'+'-$languageCode.txt');
      setState(() {
        _classContent += '$classContent\n \n'; // Add content of each class file
      });
    }
  }



  Future<void> _getVideo() async {
    // Open gallery to select video
    final pickedFile = await ImagePicker().getVideo(
        source: ImageSource.gallery);
    setState(() {
      _classContent = '';
      classes = {};
      _controller = null;
      if (pickedFile != null) {
        // Upload and process the selected video
        _video = pickedFile;
        _uploadAndProcessVideo(File(pickedFile.path));
      }
    });

  }

  Future<void> _clickVideo() async {
    // Open gallery to select video
    final pickedFile = await ImagePicker().getVideo(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        // Upload and process the selected video
        _video = pickedFile;
        _uploadAndProcessVideo(File(pickedFile.path));
      }
    });
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse('https://demo.roboflow.com/merged-project-2/1?publishable_key=rf_apaERcZDVwWRRD8ZkSXwgne1vUf1'))) {
      throw Exception('Could not launch ');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    audioPlayer.stop();

    super.dispose();
  }

}


