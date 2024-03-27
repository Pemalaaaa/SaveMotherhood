import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pema_la/screens/AddDoctorScreen.dart';
import 'package:pema_la/screens/DashboardScreen.dart';
import 'package:pema_la/screens/ProfileScreen.dart';
import 'package:pema_la/screens/ShoppingScreen.dart';
import 'package:pema_la/screens/TodoScreen.dart';
import 'package:pema_la/screens/ViewOfDoctorsScreen.dart';
import 'package:pema_la/screens/loginScreen.dart';
import 'package:pema_la/screens/onboarding_screen.dart';
import 'package:pema_la/widgets/Navbar.dart';

void main() async {
  //initializing the hive
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('mybox');

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/onbording',
      routes: {
        '/onbording':(context) => OnBoardingScreen(),
        '/dashboad': (context) => DashboardScreen(),
        '/navbar': (context) => Navbar(),
        '/todo': (context) => TodoScreen(),
        '/profile': (context) => ProfileScreen(),
        '/add doctor': (context) => AddDoctorScreen(),
        '/view': (context) => ViewOfDoctorScreen(),
        '/shop': (context) => ShoppingScreen(),
        '/login':(context) => LoginPage()
      }));
}
