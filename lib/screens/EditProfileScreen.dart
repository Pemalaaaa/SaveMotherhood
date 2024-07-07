import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pema_la/LocalStorage/SharedPref.dart';
import 'package:pema_la/Services/Auth.dart';
import 'package:pema_la/global_variables.dart';
import 'package:pema_la/models/user.dart';
import 'package:pema_la/widgets/ESnackBar.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  File? img;

  void openCamera() async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }

    final imagePicker = ImagePicker();
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, ImageSource.camera),
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
              child: const Text("Gallery"),
            ),
          ],
        );
      },
    );

    if (imageSource != null) {
      final image = await imagePicker.pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
      }
    }
  }

  Future<void> updateProfile() async {
    try {
      String? uploadProfileUrl;

      // Get the current user ID
      final userID = FirebaseAuth.instance.currentUser!.uid;

      // If an image is selected, upload it to Firebase Storage
      if (img != null) {
        uploadProfileUrl = await Authentication().uploadProfileToFirebase(img!);
      }

      // Create an instance of Users with updated profile data
      final updatedProfile = Users(
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        profileUrl:
            uploadProfileUrl ?? profileUrl ?? "https://via.placeholder.com/150",
      );

      // Update the user profile in Firebase Firestore
      await Authentication().updateProfile(userID, updatedProfile);

      // Update the user data in shared preferences
      await SharedPref().updateUserData(updatedProfile);

      // Update the profile URL in the State
      setState(() {
        profileUrl = updatedProfile.profileUrl;
      });

      // Show success message
      ESnackBar.showSuccess(context, 'Profile Updated');
    } catch (e) {
      // Show error message
      ESnackBar.showError(context, 'Failed to update profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile',style: TextStyle(fontWeight: FontWeight.bold),),
          backgroundColor: Color(0xFFFFC2CD),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  children: [
                    img == null
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(profileUrl == null
                                ? 'https://via.placeholder.com/150'
                                : profileUrl!))
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                img != null ? FileImage(img!) : null,
                          ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            openCamera();
                          },
                          icon: const Icon(Icons.camera_alt_rounded),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              TextField(
                controller: _firstnameController,
                decoration: InputDecoration(labelText: 'Firstname'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _lastnameController,
                decoration: InputDecoration(labelText: 'Lastname'),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.edit,
                    size: 30,
                  ),
                  onPressed: updateProfile,
                  label: Text(
                    'Update',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
