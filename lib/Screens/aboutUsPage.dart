import 'package:cocoa_video_app/constants/constants.dart';
import 'package:flutter/material.dart';


class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate(context, 'about_us')),
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
          child: Text(Translate(context, 'about')),
        ),
      ),
    );
  }
}