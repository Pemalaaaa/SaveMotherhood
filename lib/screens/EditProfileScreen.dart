import 'package:flutter/material.dart';
import 'package:pema_la/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  // Fetch initial data from shared preferences
  _fetchInitialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstnameController.text = prefs.getString('firstname') ?? '';
      _lastnameController.text = prefs.getString('lastname') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
    });
  }

  // Update data in Firebase
  _updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('users').doc(userID).update({
      'firstname': _firstnameController.text,
      'email': _emailController.text,
      'lastname': _lastnameController.text,
    }).then((value) {
      prefs.setString('firstname', _firstnameController.text);
      prefs.setString('lastname', _lastnameController.text);
      prefs.setString('email', _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _updateData, //to directly access the globalVariable
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstnameController,
              decoration: InputDecoration(labelText: 'firstname'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _lastnameController,
              decoration: InputDecoration(labelText: 'lastname'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
      ),
    );
  }
}
