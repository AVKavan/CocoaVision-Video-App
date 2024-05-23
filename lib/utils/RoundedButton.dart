import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Color? colour;
  final IconData icons;
  final void Function() onpressed;
  RoundedButton(
      {required this.title,
        this.colour,
        required this.onpressed,
        required this.icons});

  @override
  Widget build(BuildContext context) {
    return  TextButton(
        onPressed: onpressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icons,
              color: Colors.white,
              size: 80
            ),
            Text(
              title,
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

    );
  }
}
