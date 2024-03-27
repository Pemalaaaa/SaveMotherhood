import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Color(0xFFF7E5E7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/intopics/notification-removebg-preview.png"),
          SizedBox(
            height: 4,
          ),
          Text(
            "Stay organized throughout your pregnancy journey",
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
