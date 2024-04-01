import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pema_la/global_variables.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 80,
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
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: Size.fromHeight(50)),
                  child: Text("Logout ")),
            ],
          ),
        ));
  }
}
