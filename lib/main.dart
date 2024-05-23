import 'package:cocoa_video_app/Screens/LoadingPage.dart';
import 'package:cocoa_video_app/Screens/OrganicMethods.dart';
import 'package:cocoa_video_app/Screens/Selection_page.dart';
import 'package:cocoa_video_app/Screens/SettingsPage.dart';
import 'package:cocoa_video_app/Screens/VideoPrediction.dart';
import 'package:cocoa_video_app/Screens/aboutUsPage.dart';
import 'package:cocoa_video_app/Screens/disease_prediction.dart';
import 'package:cocoa_video_app/Screens/growth.dart';
import 'package:cocoa_video_app/Screens/About Cocoa.dart';
import 'package:cocoa_video_app/Screens/health_benefits.dart';
import 'package:cocoa_video_app/Screens/homePage.dart';
import 'package:cocoa_video_app/Screens/languageScreen.dart';
import 'package:cocoa_video_app/Screens/test.dart';
import 'package:cocoa_video_app/constants/constants.dart';
import 'package:cocoa_video_app/controller/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.containsKey('isFirstLaunch') ? false : true;

  runApp(MyApp(isFirstLaunch: isFirstLaunch));

}

class MyApp extends StatefulWidget {

  final bool isFirstLaunch;

  const MyApp({Key? key, required this.isFirstLaunch}) : super(key: key);
  

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Locale? _locale;

  setLocale(Locale locale)  {

    setState(() {
      _locale = locale;
    });
  }



  // Future<void> _checkLanguagePreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     Locale _locale = Locale(prefs.getString(savedlang) ?? 'en', prefs.getString(savedCountry) ?? 'US');
  //     MyApp.setLocale(context, _locale);
  //   });
  //
  //   print(prefs.getString(savedlang));
  // }


  // @override
  // void initState() {
  //   _checkLanguagePreference();
  // }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        routes: {
           '/' : (context) => Welcome(),
          '/home_page': (context) =>  widget.isFirstLaunch ? LanguageScreen() : HomePage(),
          '/settings': (context) => SettingsPage(),
          '/about_us' :(context) => AboutPage(),
          '/selection_page' : (context) => SelectionPage(),
          '/image_prediction' : (context) => ImagePrediction(),
          '/video_prediction' : (context) => VideoUploadScreen(),
          '/growth': (context) => Growth(),
          '/about_cocoa': (context) => About_Cocoa(),
          '/health_benefits' : (context) => HealthBenefits(),
          '/organic_methods': (context) => OrganicMethods()

        },
      locale: _locale,
      supportedLocales: [
        Locale('en','US'),
        Locale('kn','IN'),
        Locale('te','IN')
      ],
      localizationsDelegates: [
          LocalizationController.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      localeResolutionCallback: (deviceLocale,supportedLocales){
        for(var locale in supportedLocales){
          if(locale.languageCode == deviceLocale?.languageCode && locale.countryCode == deviceLocale?.countryCode){
            return deviceLocale;
          }
        }

        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,

    );
  }
}
