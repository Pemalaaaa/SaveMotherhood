
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pema_la/Services/Auth.dart';
import 'package:pema_la/firebase_options.dart';
import 'package:pema_la/notification/PeriodicNotify.dart';
import 'package:pema_la/notification/noticationController.dart';
import 'package:pema_la/notification/notificationdata.dart';
import 'package:pema_la/screens/AddDoctorScreen.dart';
import 'package:pema_la/screens/DashboardScreen.dart';
import 'package:pema_la/screens/EditProfileScreen.dart';
import 'package:pema_la/screens/ProfileScreen.dart';
import 'package:pema_la/screens/RegisterScreen.dart';
import 'package:pema_la/screens/ShoppingScreen.dart';
import 'package:pema_la/screens/TodoScreen.dart';
import 'package:pema_la/screens/ViewOfDoctorsScreen.dart';
import 'package:pema_la/screens/loginScreen.dart';
import 'package:pema_la/screens/onboarding_screen.dart';
import 'package:pema_la/widgets/Navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Auto Login
  User? user = await Authentication().autoLogin();
  //initializing the hive
  await Hive.initFlutter();

  //open a box
   var box = await Hive.openBox('mybox');
   //for notification
  Get.put(NotificationController());

  AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher',
    [
      NotificationChannel(
        channelKey: 'added_event',
        channelName: 'Added Event Notification',
        channelDescription: 'Added Notification channel For tests',
        playSound: true,
        enableVibration: true,
        defaultColor: Colors.blue,
      ),
      NotificationChannel(
        channelKey: 'event_reminder',
        channelName: 'Event Reminder notifications',
        channelDescription: 'Even Notification channel For basic tests',
        playSound: true,
        enableVibration: true,
        defaultColor: Color(0xFFF7E5E7),
      ),
    ],
  );
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,

       initialRoute: user != null
        ? '/navbar'
        : '/login', // what we need to dislay we can write here

      routes: {
        '/onbording': (context) => OnBoardingScreen(),
        '/dashboad': (context) => DashboardScreen(),
        '/navbar': (context) => Navbar(),
        '/todo': (context) => TodoScreen(),
        '/profile': (context) => ProfileScreen(),
        '/add_doctor': (context) => AddDoctorScreen(),
        '/view': (context) => ViewOfDoctorScreen(),
        '/shop': (context) => ShoppingScreen(),
        '/periodic': (context) => PerodicNotify(),
        '/Notification': (context) => NotificationCheckUp(),
        '/profileId':(context)=>ProfileScreen(),

        //make login funcion
         '/login': (context) => LoginScreen(),
          '/register':(context)=>RegisterScreen(),

          //Edit profile:
          '/editprofile':(context)=>EditProfile(),
          
          

      }
      )
      );
}
