import 'package:cocoa_video_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Growth extends StatefulWidget {
  const Growth({Key? key}) : super(key: key);

  @override
  State<Growth> createState() => _GrowthState();
}

class _GrowthState extends State<Growth> {
  String data = 'Error';

  fetchData() async {
    final locale = await getLocale();
    String languageCode = locale.languageCode;
    String response = '';
    response =
    await rootBundle.loadString('assets/recommendation_text/growth-'+'$languageCode'+'.txt');
    setState(() {
      data = response;
      print(data);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    // getWeb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Color(0xFF008080).withOpacity(0.9),
          foregroundColor: Colors.white,
          title: Text('Cocoa Growth Requirements'),
        ),

        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/cocoa_bg_img.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.2)),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  scrollDirection: Axis.vertical,
                  child: Text(
                    data,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
