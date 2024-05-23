import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';


class LocalizationController {
  // final SharedPreferences sharedPreferences;
  //
  // LocalizationController({required this.sharedPreferences}){
  //   loadCurrentLanguage();
  // }
  //
  // Locale _locale = Locale(AppConstants.languages[0].languageCode,AppConstants.languages[0].countryCode);
  // Locale get locale => _locale;
  //
  // int _selectedIndex = 0;
  // int get selectedIndex => _selectedIndex;
  //
  // List<LanguageModel> _languages = [];
  // List<LanguageModel> get languages => _languages;
  //
  // void loadCurrentLanguage() async {
  //
  //   _locale = Locale(sharedPreferences.getString(AppConstants.LanguageCode) ??
  //             AppConstants.languages[0].languageCode,
  //              sharedPreferences.getString(AppConstants.CountryCode) ??
  //             AppConstants.languages[0].countryCode);
  //
  //   for(int index = 0;index <AppConstants.languages.length;index++)
  //     {
  //       if(AppConstants.languages[index].languageCode == _locale.languageCode)
  //         {
  //           _selectedIndex = index;
  //           break;
  //         }
  //     }
  //
  //     _languages = [];
  //   _languages.addAll(AppConstants.languages);
  //   update();
// }

  final Locale locale;

  LocalizationController(this.locale);



  static LocalizationController of(BuildContext context) {
    return Localizations.of<LocalizationController>(context, LocalizationController)!;

  }

  static Map<String,String>? _localizedValues;

  Future load() async{
    String jsonStringValues = await rootBundle.loadString('lib/language/${locale.languageCode}.json');

    Map<String,dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key,value) => MapEntry(key, value.toString()));


  }

  String? getTranslatedValue(String key)
  {
    return _localizedValues?[key];
  }

  static const LocalizationsDelegate<LocalizationController> delegate = _LangLocalizationDelegate();

}

class _LangLocalizationDelegate extends LocalizationsDelegate<LocalizationController>{
  const _LangLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','kn','te'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationController> load(Locale locale) async{
    LocalizationController localization = LocalizationController(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_LangLocalizationDelegate old) => false;

  
}