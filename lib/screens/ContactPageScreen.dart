// import 'package:flutter/material.dart';
// import 'package:pema_la/models/DoctorData.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ContactPageScreen extends StatefulWidget {
//   final List<Doctor> doctors;

//   ContactPageScreen({required this.doctors});

//   @override
//   State<ContactPageScreen> createState() => _ContactPageState();
// }

// class _ContactPageState extends State<ContactPageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Contact Doctors"),
//       ),
//       body: ListView.builder(
//         itemCount: widget.doctors.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(widget.doctors[index].name),
//             subtitle: Text(widget.doctors[index].hospital), // Display hospital information
//             trailing: IconButton(
//               onPressed: () {
//                 _call(widget.doctors[index].phone);
//               },
//               icon: Icon(Icons.call),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _call(String phoneNumber) async {
//     final String url = 'tel:$phoneNumber';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       print("Could not launch $url");
//     }
//   }
// }
