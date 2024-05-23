import 'package:cocoa_video_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganicMethods extends StatelessWidget {
  const OrganicMethods({super.key});

  final String link1 = 'https://www.youtube.com/watch?v=-BH5BhqJyRs';
  final String link2 = 'https://www.youtube.com/watch?v=JUzzOtd14aU';
  final String link3 = 'https://www.youtube.com/watch?v=9NA7dHM0SE8';
  final String link4 = 'https://www.youtube.com/watch?v=GyNXUYMZyyc';
  final String link5 = 'https://www.youtube.com/watch?v=1KedwIQ9jCI';
  final String link6 = 'https://www.youtube.com/watch?v=zCeymfeRVhY';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF008080).withOpacity(0.9),
        foregroundColor: Colors.white,
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
              Text(
                Translate(context,"link_descrp"),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.04
              ),
              Container(
                height: MediaQuery.sizeOf(context).height*0.07,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    _launchUrl(link1);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Translate(context,"link1"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF008080).withOpacity(0.8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.02
              ),
              Container(
                height: MediaQuery.sizeOf(context).height*0.07,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    _launchUrl(link2);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Translate(context,"link2"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF008080).withOpacity(0.8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.02
              ),
              Container(
                height: MediaQuery.sizeOf(context).height*0.07,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    _launchUrl(link3);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Translate(context,"link3"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF008080).withOpacity(0.8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.02
              ),
              Container(
                height: MediaQuery.sizeOf(context).height*0.07,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    _launchUrl(link4);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        Translate(context,"link4"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23

                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF008080).withOpacity(0.8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.02
              ),
              Container(
                height: MediaQuery.sizeOf(context).height*0.07,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    _launchUrl(link5);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        Translate(context,"link5"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF008080).withOpacity(0.8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.02
              ),
              Container(
                height: MediaQuery.sizeOf(context).height*0.07,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    _launchUrl(link6);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        Translate(context,"link6"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF008080).withOpacity(0.8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),

                ),
              ),
            ]
        ),
      ),

    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ');
    }
  }
}

