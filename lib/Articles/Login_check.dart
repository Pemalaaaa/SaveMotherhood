// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pema_la/screens/DashboardScreen.dart';
// import 'package:pema_la/screens/loginScreen.dart';

// class LoginCheck extends StatelessWidget {
//   const LoginCheck({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: ((context, snapshot) {
//           if (snapshot.hasData) {
//             return const DashboardScreen();
//           } else {
//             return const LoginPage();
//           }
//         }),
//       ),
//     );
//   }
// }
 