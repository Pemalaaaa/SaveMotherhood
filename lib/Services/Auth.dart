import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pema_la/LocalStorage/SharedPref.dart';
import 'package:pema_la/models/user.dart';

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
      var convertedResult = Users().fromJson(result.data()!);
      print(convertedResult.firstname);
      // Set that data to local storage globally
      SharedPref().setUserData(userID, convertedResult);

      // isLogin is true
      isLogin = true;
    // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => {isLogin = false});

    return isLogin;
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
        .collection('users')
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
}
