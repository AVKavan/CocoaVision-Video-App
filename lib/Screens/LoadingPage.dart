import 'package:cocoa_video_app/Screens/languageScreen.dart';
import 'package:cocoa_video_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cocoa_video_app/Screens/homePage.dart';

class Welcome extends StatefulWidget {
   const Welcome({Key? key}) : super(key: key);
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

   Future<String?> check = getLang();




  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushNamedAndRemoveUntil('/home_page', (route) => false)
    );
  }

  late Timer _timer;
  int _start = 3;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cocoa_bg_img.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Container(
                  height: 180,
                  child: Image.asset('assets/images/cocoa_logo.png')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Cocoa Vision',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    // fontSize: animation.value * 38,
                    fontSize: animation.value * 40,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
