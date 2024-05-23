import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cocoa_video_app/constants/constants.dart';
import 'package:cocoa_video_app/controller/TexttoSpeech.dart';
import 'package:cocoa_video_app/controller/locationController.dart';
import 'package:cocoa_video_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:cocoa_video_app/utils/RoundedButton.dart';
import 'package:path_provider/path_provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final WeatherFactory _wf = WeatherFactory(OPEN_WEATHER_API_KEY);
  Weather? _weather;


  final locationController locationControl = locationController();

  final FlutterTts flutterTts = FlutterTts();
  String? _audioContent;

  double temperature = 0;
  double humidity = 0;
  double windspeed = 0;
  double precip = 0;

  // Future<void> _synthesizeText(String s) async {
  //   final text = s;
  //   String name = 'kn-IN-Wavenet-A';
  //   final locale = await getLocale();
  //   String languageCode = locale.languageCode;
  //   String? countryCode = locale.countryCode;
  //   if(languageCode == 'te')
  //     name = 'te-IN-Standard-A';
  //
  //   final lang = '$languageCode'+'_'+'$countryCode';
  //   final api = TextToSpeechAPI();
  //   final audioContent = await api.synthesizeText(text, name, lang);
  //   setState(() {
  //     _audioContent = audioContent;
  //   });
  //
  //   // final path = await getTemporaryDirectory();
  //   // final file = File('${path.path}/temp.mp3');
  //   // if (!await file.exists()) {
  //     final audioBytes = base64Decode(_audioContent!);
  //   //   await file.writeAsBytes(audioBytes);
  //   // }
  //   await AudioPlayer().play(BytesSource(audioBytes));
  // }

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
  speak(String text) async {
    final locale = await getLocale();
    String languageCode = locale.languageCode;
    String? countryCode = locale.countryCode;
    await flutterTts.setLanguage("te-IN");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
    var list = await flutterTts.getLanguages;
    print(list);
  }


  getWeather() async{
    Locale _loc = await getLocale();
    MyApp.setLocale(context, _loc);
    await locationControl.getPermission();
    await getLocation();

    String? cityname = await getTranslatedCityName();

     _wf.currentWeatherByLocation(LATITUDE,LONGITUDE ).then((w) {
      setState(() {
        CITY = cityname;
        _weather = w;
        // temperature = _weather!.temperature!.celsius!;
        // humidity = _weather!.humidity!;
        // windspeed = _weather!.windSpeed!*3.6 ;
        // precip = _weather!.rainLastHour! ;

        print(_weather);
      });
    });

  }

  getLocation() async{
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      LATITUDE = position.latitude;
      LONGITUDE = position.longitude;
    });

  }


  @override
  void initState()  {
    super.initState();
    getWeather();
    getTranslatedCityName();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF008080).withOpacity(0.9),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
                Icons.location_on,
                color: Colors.white,
                size: 30
            ),
            Text(CITY ?? "Location Off",
            style: TextStyle(
              color: Colors.white
            ),),
          ],
        ),
      ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: _drawerList(),
        ),
       body:  Container(
           height: MediaQuery.sizeOf(context).height,
           width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
             image: DecorationImage(
                 image: AssetImage('assets/images/cocoa_bg_img.jpg'),
                 fit: BoxFit.cover,
                 opacity: 0.6),
          ),
           child:  Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
                 //Weather temp and condtions info
                 Padding(
                   padding: const EdgeInsets.only(top: 20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       _weatherIcon(),
                       _currentTemp()

                     ],

                     ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       weatherInfoCard("${_weather == null? 0 : _weather?.humidity?.toStringAsFixed(0)}",Translate(context, "humidity"), "%"),
                       weatherInfoCard("${_weather == null? 0 :_weather?.tempMax?.celsius?.toStringAsFixed(0)}",Translate(context, "maxTemp"), "° C"),
                       weatherInfoCard("${_weather == null? 0 : (_weather!.windSpeed! * 3.6)?.toStringAsFixed(0)
                       }",Translate(context, "windspeed")," Km/h")
                     ],
                   ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Container(
                       height: MediaQuery.sizeOf(context).height*0.13,
                       width: MediaQuery.sizeOf(context).width*0.93,
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
                           padding: EdgeInsets.all(5),
                           child: TextButton(
                             onPressed: () async{
                              await  _verdictForPesticides() ? synthesizeText(Translate(context,"apply_pesticide")) : synthesizeText(Translate(context,"donotapply_pesticide"));
                             },
                             child:

                             Text(

                               _verdictForPesticides() ? Translate(context,"apply_pesticide") : Translate(context,"donotapply_pesticide"),
                               style: TextStyle(
                                 color: Colors.black87,
                                 fontSize: 19
                             ),
                             ),
                           ),
                       ),
                     ),

                 ],
               ),
                 SizedBox(
                   height: MediaQuery.sizeOf(context).height*0.018
                 ),
                 Container(
                   height: MediaQuery.sizeOf(context).height*0.19,
                     width: MediaQuery.sizeOf(context).width*0.93,
                   decoration: BoxDecoration(

                   ),

                     child: RoundedButton(
                     title: Translate(context, "detect_disease"),
                     onpressed: () {

                       Navigator.pushNamed(context, '/selection_page');
                     },
                     icons: Icons.search_rounded,
                   )
                 ),
               SizedBox(
                   height: MediaQuery.sizeOf(context).height*0.018
               ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                   children: [
                     // Container(
                     //     height: MediaQuery.sizeOf(context).height*0.2,
                     //     width: MediaQuery.sizeOf(context).width*0.45,
                     //
                     //     child: RoundedButton(
                     //       title: Translate(context,"growth_needs"),
                     //       onpressed: () {
                     //         Navigator.pushNamed(context, '/growth');
                     //       },
                     //       icons: Icons.arrow_circle_right_sharp,
                     //     )
                     // ),
                     Container(
                         height: MediaQuery.sizeOf(context).height*0.19,
                         width: MediaQuery.sizeOf(context).width*0.93,

                         child: RoundedButton(
                           title: Translate(context,"about_cocoa"),
                           onpressed: () {
                             Navigator.pushNamed(context, '/about_cocoa');
                           },
                           icons: Icons.arrow_circle_right_sharp,
                         )
                     ),
                   ],
                 )


             ],
           ),
         ),

    );
  }


  // Widget _dateTime()
  // {
  //   DateTime _now = _weather!.date!;
  //   return Row(
  //     children: [
  //       Text(
  //         DateFormat("h:mm a").format(_now),
  //       )
  //     ],
  //   );
  // }



  _verdictForPesticides()
  {
    if(temperature > 18 && temperature < 30 && humidity > 60 && humidity < 80 && windspeed < 10 && precip < 5  )
      return true;
    else return false;
  }


  Widget _weatherIcon()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: MediaQuery.sizeOf(context).height*0.1,
            width: MediaQuery.sizeOf(context).width*0.4,
            decoration: BoxDecoration(

              image: DecorationImage(
                image: NetworkImage("https://openweathermap.org/img/wn/${_weather?.weatherIcon == null? "01d" : _weather?.weatherIcon}@4x.png"),
                fit: BoxFit.cover
              )
            ),
        ),
        Text(
          Translate(context, _weather?.weatherDescription ?? "clear sky")?? "",
          style: TextStyle(
              fontSize: 17, fontFamily: "PoppinsLight"
          ),

        )
      ],
    );
  }

  Widget _currentTemp()
  {
    return
       Text(
          "${_weather == null ? 0 : _weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
          style: const TextStyle(
              fontSize: 65, fontFamily: "PoppinsLight"
          ),


    );
  }

  Widget weatherInfoCard(String info,String about,String unit)
  {
    return Container(
      height: MediaQuery.sizeOf(context).height*0.13,
      width: MediaQuery.sizeOf(context).width*0.27,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(about,
            style: const TextStyle(
                fontSize: 17,
                fontFamily: "PoppinsLight"
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                info,
                style: const TextStyle(
                    fontSize: 30,
                    fontFamily: "PoppinsLight"
                ),
              ),
              Text(
                unit,
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: "PoppinsLight"
                ),
              ),
            ],
          ),
        ],
      ),


    );
  }

  Container _drawerList() {
    TextStyle _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
    );
    return Container(
      color: Colors.teal,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              height: 70,
              child: CircleAvatar(),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              Translate(context, 'about_us'),
              style: _textStyle,
            ),
            onTap: () {
              // To close the Drawer
              Navigator.pop(context);
              // Navigating to About Page
              Navigator.pushNamed(context, '/about_us');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              Translate(context, 'settings'),
              style: _textStyle,
            ),
            onTap: () {
              // To close the Drawer
              Navigator.pop(context);
              // Navigating to About Page
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }



}
