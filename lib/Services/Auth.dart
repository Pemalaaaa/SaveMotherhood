import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pema_la/LocalStorage/SharedPref.dart';
import 'package:pema_la/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Authentication {
  // Make a login function
  Future<bool> login(String email, String password) async {
    // declare a login variable
    bool isLogin = false;

    // make a firebase request
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      // Fetch the user data form firestore
      // get the user id
      String? userID = value.user!.uid;
      var result = await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .get();

      // Convert the result
      var decodedJson = Users.fromJson(result.data()!);

      SharedPref().setUserData(decodedJson, userID);

      // isLogin is true
      isLogin = true;
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => {isLogin = false});

    return isLogin;
  }

  Future<void> signOut() async {
    var auth = FirebaseAuth.instance;
    await auth.signOut();
    await SharedPref().removeUserData();
  }

  // Make a register function
  Future<bool> register(
      String firstname, String lastname, String email, String password) async {
    bool isRegister = false;

    // First register the user in Authentication
    UserCredential registeredUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Get the registed user UID
    String userID = registeredUser.user!.uid;

    // Then register the user with extra Info in Firestore
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .set({
          "firstname": firstname,
          "lastname": lastname,
          "email": email,
          "password": password
        })
        .then((value) => {isRegister = true})
        .catchError((error) => {isRegister = false});

    return isRegister;
  }

  // Auto login
  Future<User?> autoLogin() async {
    var _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    return user;
  }

  //profile edit
  Future<String?> uploadProfileToFirebase(File imageFile) async {
    try {
      final path = 'profile/${DateTime.now()}.png';
      final file = File(imageFile.path);
      final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error Uploading image to Firebase Storage: $e');
      return null;
    }
  }

  Future<void> updateProfile(userID, Users user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .update(user.toJson());
    } catch (e) {
      print('Error updating profile: $e');
    }
  }
}
