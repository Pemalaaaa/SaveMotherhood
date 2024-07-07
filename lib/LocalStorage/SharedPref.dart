import 'package:pema_la/models/DoctorData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pema_la/global_variables.dart';

class SharedPref {
  Future<void> setUserData(userId, data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("userID", userId);
      await prefs.setString("firstname", data.firstname);
      await prefs.setString("lastname", data.lastname);
      await prefs.setString("email", data.email);
      await prefs.setString("profileUrl", data.profileUrl);
      print("User data set successfully");
    } catch (e) {
      print("Error setting user data: $e");
    }
  }

  Future<void> getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userID = prefs.getString("userID");
      firstname = prefs.getString("firstname");
      lastname = prefs.getString("lastname");
      email = prefs.getString("email");
      profileUrl = prefs.getString("profileUrl");

      print("User ID: $userID");
    } catch (e) {
      print("Error getting user data: $e");
    }
  }

  Future<void> updateUserData(updatedProfile) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Use null-aware operators to handle null values
      await prefs.setString('firstname', updatedProfile.firstname ?? '');
      await prefs.setString('lastname', updatedProfile.lastname ?? '');
      await prefs.setString('email', updatedProfile.email ?? '');
      await prefs.setString('profileUrl', updatedProfile.profileUrl ?? '');
      print("User data updated successfully");
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  Future<void> removeUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userID');
      await prefs.remove('firstname');
      await prefs.remove('lastname');
      await prefs.remove('email');
      await prefs.remove('profileUrl');
      print("User data removed successfully");
    } catch (e) {
      print("Error removing user data: $e");
    }
  }

  Future<void> setDoctorDataToSharedPreferences(Doctor doctor) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("doctorName", doctor.name);
      await prefs.setString("hospitalName", doctor.hospital);
      await prefs.setString("phoneNumber", doctor.phone);
      print("Doctor data set successfully");
    } catch (e) {
      print("Error setting doctor data: $e");
    }
  }

  Future<void> getDoctorDataFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      name = prefs.getString("doctorName") ?? '';
      hospital = prefs.getString("hospitalName") ?? '';
      phone = prefs.getString("phoneNumber") ?? '';
      print("Doctor data retrieved successfully");
    } catch (e) {
      print("Error getting doctor data: $e");
    }
  }

   
}
