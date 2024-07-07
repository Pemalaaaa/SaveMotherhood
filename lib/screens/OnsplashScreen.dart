import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
         color: Color(0xFFF7E5E7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Image.asset('assets/intopics/logo.png', width: 200, height: 400),
            Center(
              child: Text('Welcome to Save Motherhood !!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height:10),
            Text("A magical journey of creation, love, and boundless joy"),
            SizedBox(height:30),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/onbording');
                  },
                  child: const Text("Let's get started!",style: TextStyle(fontWeight:FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFC2CD),
                          foregroundColor: Colors.white,
                          minimumSize: Size.fromHeight(50)
                  ),),
            )
          ],
        ),
      ),
    );
  }
}