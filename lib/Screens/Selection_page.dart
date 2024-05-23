import 'package:cocoa_video_app/constants/constants.dart';
import 'package:cocoa_video_app/utils/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF008080).withOpacity(0.9),
        foregroundColor: Colors.white,
        title: Text(
          Translate(context,"detect_disease"),
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
                height: MediaQuery.sizeOf(context).height*0.2,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: RoundedButton(
                  title: Translate(context,"image_prediction"),
                  onpressed: () {
                     Navigator.pushNamed(context, '/image_prediction');
                  },
                  icons: Icons.image,
                )
            ),
            SizedBox(
                height: MediaQuery.sizeOf(context).height*0.04
            ),
            Container(
                height: MediaQuery.sizeOf(context).height*0.2,
                width: MediaQuery.sizeOf(context).width*0.93,

                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/video_prediction');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                          Icons.video_camera_back_outlined,
                          color: Colors.white,
                          size: 80
                      ),
                      Text(
                        Translate(context,"video_prediction"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19
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

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse('https://app.roboflow.com/majorproject-rlkpl/merged-project-2/visualize/1'))) {
      throw Exception('Could not launch ');
    }
  }
}
