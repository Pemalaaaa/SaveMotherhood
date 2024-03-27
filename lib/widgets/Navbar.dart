import 'package:flutter/material.dart';
import 'package:pema_la/models/DoctorData.dart';
import 'package:pema_la/screens/AddDoctorScreen.dart';
import 'package:pema_la/screens/DashboardScreen.dart';
import 'package:pema_la/screens/ProfileScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  // 1. Selecting an index from where to start
  int _selectedIndex = 0;

  //initializeing an empty list of doctors
  List<Doctor> doctors = [];

  // 2. Making a list of screens to show while clicking
  final List<Widget> screens = [
    DashboardScreen(),
    AddDoctorScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: screens.elementAt(_selectedIndex)),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.phone, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        color: Color(0xFFFFC2CD),
        buttonBackgroundColor: Color(0xFFFFC2CD),
        backgroundColor: Color(0xFFF7E5E7),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
