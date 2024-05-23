import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:cocoa_video_app/constants/constants.dart';
import 'package:cocoa_video_app/controller/TexttoSpeech.dart';
import 'package:cocoa_video_app/utils/SelectionButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class ImagePrediction extends StatefulWidget {
  const ImagePrediction({super.key});

  @override
  _ImagePredictionState createState() => _ImagePredictionState();
}

class _ImagePredictionState extends State<ImagePrediction> {
  final _picker = ImagePicker();
  PickedFile? _image;
  ImageProvider? _annotatedImage;
  String? _errorMessage;
  List<dynamic>? _classId;
  String data = '';
  String _classContent = '';


  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    // Stop audio playback when the screen is disposed
    audioPlayer.stop();
    super.dispose();
  }


  String? audioContent;

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

  Future<void> _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _classContent = '';
      _classId = null;
      if (pickedFile != null) {
        _image = pickedFile;
        _annotatedImage = null;
        _errorMessage = null;
        _predictImage();
      }
    });
  }

  Future clickImage() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _classContent = '';
      _classId = null;
      if (pickedFile != null) {
        _image = pickedFile;
        _annotatedImage = null;
        _errorMessage = null;
        _predictImage();
      }
    });
  }

  Future<void> _predictImage() async {
    if (_image == null) return;

    final uri = Uri.parse('https://65f7-106-51-8-242.ngrok-free.app/predict');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      final classList = json.decode(response.headers['x-class-list']!) as List<
          dynamic>;
      final filteredClassList = classList
          .where((element) => element != 'null').toSet().toList();
      final annotatedImage = await response.stream.toBytes();
      setState(() {
        _annotatedImage = MemoryImage(annotatedImage);
        print(filteredClassList);
        if(filteredClassList.isNotEmpty) {
          _classId = filteredClassList;
          _loadClassContent();
        }
        if(filteredClassList.isEmpty)
          _classId = ['HEALTHY'];
      });
    } else {
      setState(() {
        _errorMessage = 'Error: ${response.reasonPhrase}';
      });
    }
  }

  Future<void> _loadClassContent() async {
    // Assuming your .txt files are in the 'assets' folder
    for (var classId in _classId!) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF008080).withOpacity(0.9),
        foregroundColor: Colors.white,
        title: Text(
          Translate(context,"image_prediction"),
          style: TextStyle(
              color: Colors.white,
              fontSize: 19
          ),
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // if (_image != null)
                  //   Image.file(File(_image!.path)),
                  // const SizedBox(height: 20.0),

                  Container(
                    height: MediaQuery.sizeOf(context).height*0.06
                    ,
                    width: MediaQuery.sizeOf(context).width*0.94,
                    child: SelectionButton(
                      title: Translate(context,"gallery"),
                      onpressed: _getImage,
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
                      onpressed: clickImage,
                      icons: Icons.camera,
                    ),
                  ),
                  if (_annotatedImage == null && _image !=null && _errorMessage == null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  if (_annotatedImage != null)
                    SizedBox(height: 20.0),
                  if (_annotatedImage != null)
                    Image(image: _annotatedImage!),
                  SizedBox(height: 20.0),
                  if (_classId != null) Container(

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
                          for (var classId in _classId!)
                            Text(
                              Translate(context, '$classId')+',',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                            ),
                        ],
                    ),
                  ),
                  ),
                  if (_errorMessage != null)
                    SizedBox(height: 20.0),
                  if (_errorMessage != null)
                    Text('Error: $_errorMessage',
                        style: TextStyle(color: Colors.red)),
                  SizedBox(height: 20.0),
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
}