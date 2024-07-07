import 'package:flutter/material.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xFFF7E5E7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/intopics/addDr-removebg-preview.png"),
          SizedBox(
            height: 4,
          ),
          Text(
            "Stay Connect With Doctor",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}