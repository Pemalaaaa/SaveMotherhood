import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pema_la/LocalStorage/SharedPref.dart';
import 'package:pema_la/Services/Auth.dart';
import 'package:pema_la/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Call getUserData when the widget initializes
    getUserData();
  }

  void _logOut() async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await Authentication().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
                child: const Text('Log Out'),
              )
            ],
          );
        },
      );
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  Future<void> getUserData() async {
    try {
      await SharedPref().getUserData();
      // Call setState to update the UI with the retrieved profile URL
      setState(() {});
    } catch (e) {
      print("Error getting user data: $e");
    }
  }

  //logout function
  // Method to logout
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all user data from SharedPreferences
    // Navigate to login screen or any other screen after logout
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7E5E7),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Screen",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFFC2CD),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            CircleAvatar(
              radius: 70,
              // Use profileUrl from SharedPref
              backgroundImage: NetworkImage(
                profileUrl ?? 'https://via.placeholder.com/150',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$firstname $lastname",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("$email"),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Edit Profile"),
                    subtitle: Text("Customize your profile"),
                    leading: Icon(Icons.edit),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(context, '/editprofile');
                    },
                  ),
                  ListTile(
                    title: Text("Change Password"),
                    subtitle: Text("Give a old Passowrd "),
                    leading: Icon(Icons.lock),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(context, '/changePassword');
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _logOut();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFC2CD),
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(50),
                      ),
                      child: Text("Logout "),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
