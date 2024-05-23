import 'package:cocoa_video_app/constants/constants.dart';
import 'package:cocoa_video_app/main.dart';
import 'package:cocoa_video_app/models/Language_model.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _changeLanguage(LanguageModel language) async {

    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate(context, 'settings')),
      ),
      body: Container(
    height: MediaQuery.sizeOf(context).height,
    width: MediaQuery.sizeOf(context).width,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/images/cocoa_bg_img.jpg'),
    fit: BoxFit.cover,
    opacity: 0.6),),
        child: Center(
            child: DropdownButton<LanguageModel>(
              iconSize: 30,
              hint: Text(Translate(context, 'change_language')),
              onChanged: (LanguageModel? language) async {
                _changeLanguage(language!);
                final c =  await getTranslatedCityName();
                setState(() async {
                  CITY = c;
                });

              },
              items: LanguageModel.languageList
                  .map<DropdownMenuItem<LanguageModel>>(
                    (e) => DropdownMenuItem<LanguageModel>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        '${e.id}',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(e.languageName)
                    ],
                  ),
                ),
              )
                  .toList(),
            )),
      ),
    );
  }
}