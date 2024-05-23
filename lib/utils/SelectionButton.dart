import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  final String title;
  final Color? colour;
  final IconData icons;
  final void Function() onpressed;
  SelectionButton(
      {required this.title,
        this.colour,
        required this.onpressed,
        required this.icons});

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      onPressed: onpressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
              icons,
              color: Colors.white,
              size: 40
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
        elevation: 10,
        backgroundColor: Color(0xFF008080).withOpacity(0.8),
        shape:
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
        ),
    );
  }
}
