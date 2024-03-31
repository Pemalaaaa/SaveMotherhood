import 'package:pema_la/models/DoctorData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pema_la/global_variables.dart';

class SharedPref {
  // setting user data to local storage
  Future<void> setUserData(userID, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userID", userID);
    prefs.setString("firstname", data.firstname);
    prefs.setString("lastname", data.lastname);
    prefs.setString("email", data.email);
  }

  // get user data from local Storage
  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("USERID $firstname");

    userID = prefs.getString("userID")!;
    firstname = prefs.getString("firstname")!;
    lastname = prefs.getString("lastname")!;
    email = prefs.getString("email")!;
    print("USERID $userID");
  }

  //for doctor set
  Future<void> setDoctorDataToSharedPreferences(Doctor doctor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("doctorName", doctor.name);
    prefs.setString("hospitalName", doctor.hospital);
    prefs.setString("phoneNumber", doctor.phone);
  }

  

  //for doctor get
  Future<void> getDoctorDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("doctorName") ?? '';
    hospital = prefs.getString("hospitalName") ?? '';
    phone = prefs.getString("phoneNumber") ?? '';
   // return Doctor(name: name, hospital: hospital, phone: phone);
  }
}
