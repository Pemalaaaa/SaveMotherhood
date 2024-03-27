import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pema_la/models/DoctorData.dart';

class ViewOfDoctorScreen extends StatefulWidget {
  const ViewOfDoctorScreen({super.key});

  @override
  State<ViewOfDoctorScreen> createState() => _ViewOfDoctorScreenState();
}

class _ViewOfDoctorScreenState extends State<ViewOfDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    // Extracting arguments passed to this screen
    final args = ModalRoute.of(context)!.settings.arguments as List;
    List<Doctor> doctors = args.cast<Doctor>();

    // Function to delete a doctor from the list
    void _deleteDoctor(int index) {
      setState(() {
        doctors.removeAt(index);
      });
    }

    // Function to update a doctor's details
    void _updateDoctor(int index) {
      // Showing a dialog box to edit doctor details
      showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController nameController = TextEditingController(text: doctors[index].name);
          TextEditingController hospitalController = TextEditingController(text: doctors[index].hospital);
          TextEditingController phoneController = TextEditingController(text: doctors[index].phone);

          // Creating and returning an AlertDialog
          return AlertDialog(
            title: Text("Update Doctor"),
            content: Column(
              mainAxisSize: MainAxisSize.min, // Making the dialog box smaller
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: hospitalController,
                  decoration: InputDecoration(labelText: "Hospital"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: "Phone"),
                ),
              ],
            ),
            // the <widget> is used to show that all the code inside the actions contain the widgets like buttons,text 
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Updating the doctor details when "Update" button is pressed
                  setState(() {
                    doctors[index].name = nameController.text;
                    doctors[index].hospital = hospitalController.text;
                    doctors[index].phone = phoneController.text;
                  });
                  Navigator.of(context).pop(); // Closing the dialog box
                },
                child: Text("Update",style: TextStyle(color: Colors.black),),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Closing the dialog box
                },
                child:Text("Cancel",style: TextStyle(color: Colors.black),)
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("View Doctors"),
      ),
      backgroundColor: Color(0xFFF7E5E7),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final individualDoctor = doctors[index];
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.call),
              backgroundColor: Color(0xFFFFC2CD),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${individualDoctor.name}"),
                Text("${individualDoctor.hospital}"),
              ],
            ), 
            subtitle: Text(individualDoctor.phone),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    _deleteDoctor(index);
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    _updateDoctor(index);
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
            onTap: () {
              LaunchCaller(actionCall: 'tel:${individualDoctor.phone}');
            },
          );
        },
      ),
    );
  }

  // Function to launch the phone call action
  void LaunchCaller({required String actionCall}) async {
    print("Inside ");
    var uri = Uri.parse(actionCall);

    if (await canLaunchUrl(uri)) {
      await launchUrl(Uri.parse(actionCall));
    } else {
      print("something went wrong");
    }
  }
}
