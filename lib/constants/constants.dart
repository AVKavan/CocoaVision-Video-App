
import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:cocoa_video_app/controller/language_controller.dart';
import 'package:cocoa_video_app/models/Language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cocoa_video_app/controller/TexttoSpeech.dart';


const OPEN_WEATHER_API_KEY = 'key';
double LATITUDE = 0.0;
double LONGITUDE = 0.0;
String CITY = "";


String Translate(BuildContext context,key)
{
  return LocalizationController.of(context).getTranslatedValue(key) ?? "";
}


// const String ENGLISH = 'en';
// const String KANNADA = 'kn';
// const String TELUGU = 'te';





//
const String LANG_CODE = 'languageCode';


Future<Locale> setLocale(String languageCode) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LANG_CODE, languageCode);

  await prefs.setBool('isFirstLaunch', false);
  CITY = await getTranslatedCityName();
  return _locale(languageCode);

}

Future<String> getTranslatedCityName() async {
  final locale = await getLocale();
  String languageCode = locale.languageCode;
  String? countryCode = locale.countryCode;

  await setLocaleIdentifier('$languageCode'+'-'+'$countryCode');

  List<Placemark> placemarks = await placemarkFromCoordinates(LATITUDE, LONGITUDE);
  return placemarks[0].locality ?? "";
}

Locale _locale(String languageCode)
{
  Locale _temp;
  switch(languageCode)
  {
    case 'en':
      _temp = Locale(languageCode,"US");
          break;
    case 'kn':
      _temp = Locale(languageCode,"IN");
      break;
    case 'te':
      _temp = Locale(languageCode,"IN");
      break;
    default:
      _temp = Locale('en','US');
  }

  return _temp;

}
  Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String langCode = await _prefs.getString(LANG_CODE) ?? 'en';
    return _locale(langCode);
  }

  Future<String?> getLang() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print(_prefs.getString(LANG_CODE));
    return _prefs.getString(LANG_CODE);


}
