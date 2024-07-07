import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
   //  color: Color(0xFFF7E5E7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
        Image.asset("assets/intopics/onlineshopping-removebg-preview.png"),
       
        SizedBox(height: 4,),
        
        Text("Shop Pregnancy Product" ,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        )
        ,)
      ],),
    );
  }
}