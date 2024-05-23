import 'package:cocoa_video_app/Screens/homePage.dart';
import 'package:cocoa_video_app/constants/constants.dart';
import 'package:cocoa_video_app/models/Language_model.dart';
import 'package:flutter/material.dart';
import 'package:cocoa_video_app/main.dart';
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});


  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
   LanguageModel _selectedLanguage = LanguageModel.languageList[0];

   void _changeLanguage(LanguageModel language) async {

     Locale _locale = await setLocale(language.languageCode);
     MyApp.setLocale(context, _locale);
   }


   


   @override
  Widget build(BuildContext context) {
     if(LANG_CODE == '' )
       {
         return Container(
           child: CircularProgressIndicator(

           )
         );
       }
    else{
      print(getLang());
      return Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: Center(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset("assets/images/cocoa_logo.png",
                                  width: 120),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child:
                                  Text(Translate(context, "select_language")),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1),
                              // physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: LanguageModel.languageList.length,
                              itemBuilder: (context, index) {
                                final language =
                                    LanguageModel.languageList[index];
                                return RadioListTile<LanguageModel>(
                                  title: Text(language.languageName),
                                  value: language,
                                  groupValue: _selectedLanguage,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedLanguage = value!;
                                      _changeLanguage(_selectedLanguage);

                                    });
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                // Do something with the selected language
                                _changeLanguage(_selectedLanguage);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()),
                                );
                              },
                              child: Icon(Icons.check),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      );
    }
  }
}
