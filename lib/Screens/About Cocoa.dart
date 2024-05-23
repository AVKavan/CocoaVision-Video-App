import 'package:cocoa_video_app/constants/constants.dart';
import 'package:cocoa_video_app/utils/RoundedButton.dart';
import 'package:flutter/material.dart';

class About_Cocoa extends StatelessWidget {
  const About_Cocoa({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF008080).withOpacity(0.9),
        foregroundColor: Colors.white,
        title: Text(
          Translate(context,"about_cocoa"),
          style: TextStyle(
              color: Colors.white,
              fontSize: 19
          ),
        ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height*0.08,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/growth');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                          Icons.arrow_circle_right,
                          color: Colors.white,
                          size: 43
                      ),
                      Text(
                        Translate(context,"growth_needs"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF008080).withOpacity(0.8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
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
                height: MediaQuery.sizeOf(context).height*0.08,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/health_benefits');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                           Icons.arrow_circle_right,
                          color: Colors.white,
                          size: 43
                      ),
                      Text(
                        Translate(context,"health_benefits"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF008080).withOpacity(0.8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
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
                height: MediaQuery.sizeOf(context).height*0.08,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/organic_methods');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                          Icons.arrow_circle_right,
                          color: Colors.white,
                          size: 43
                      ),
                      Text(
                        Translate(context,"organic_methods"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF008080).withOpacity(0.8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
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
}
