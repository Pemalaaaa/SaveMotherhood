import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pema_la/models/DoctorData.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class ViewOfDoctorScreen extends StatefulWidget {
  const ViewOfDoctorScreen({Key? key});

  @override
  State<ViewOfDoctorScreen> createState() => _ViewOfDoctorScreenState();
}

class _ViewOfDoctorScreenState extends State<ViewOfDoctorScreen> {
  late List<Doctor> doctors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "View Doctor Contact",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFFC2CD),
      ),
      backgroundColor: Color(0xFFF7E5E7),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Doctor_view').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(), // Show loading indicator
            );
          }

          // Extracting documents from snapshot
          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          // Map documents to Doctor objects
          doctors = documents.map((doc) {
            return Doctor(
              name: doc['name'],
              hospital: doc['hospital'],
              phone: doc['phone'],
            );
          }).toList();

          return ListView.builder(
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
                  launchCaller(actionCall: 'tel:${individualDoctor.phone}');
                },
              );
            },
          );
        },
      ),
    );
  }

// Function to delete a doctor from Firestore
void _deleteDoctor(int index) async {
  try {
    // Get the doctor object to delete
    Doctor doctorToDelete = doctors[index];

    // Query Firestore for the document matching the properties of the doctor
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Doctor_view')
        .where('name', isEqualTo: doctorToDelete.name)
        .where('hospital', isEqualTo: doctorToDelete.hospital)
        .where('phone', isEqualTo: doctorToDelete.phone)
        .get();

    // Delete the document from Firestore
    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.delete();
    } else {
      print('Doctor not found in Firestore');
    }

    // Remove the doctor from the local list
    setState(() {
      doctors.removeAt(index);
    });
  } catch (e) {
    print("Error deleting doctor: $e");
  }
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
              child: Text(
                "Update",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Closing the dialog box
              },
              child: Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  // Function to launch the phone call action
  // Function to launch the phone call action
void launchCaller({required String actionCall}) async {
  if (await canLaunch(actionCall)) {
    await launch(actionCall);
  } else {
    print("Could not launch $actionCall");
  }
}

}
