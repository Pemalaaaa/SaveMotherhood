import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void _addDoctor() {
    // Create a map of doctor data
    Map<String, dynamic> doctorData = {
      'name': nameController.text,
      'hospital': hospitalController.text,
      'phone': phoneController.text,
    };

    // Add the doctor data to Firestore
    FirebaseFirestore.instance.collection('Doctor_view').add(doctorData);

    // Clear text controllers
    nameController.clear();
    hospitalController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFFFC2CD),
        title: Text("Add Doctors", style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/view", arguments: 'doctors' );
            },
            icon: Icon(Icons.remove_red_eye),
          )
        ],
      ),
      backgroundColor: Color(0xFFF7E5E7),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Doctor Name",
                  hintText: "Doctor Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFFFC2CD)),
                  ),
                ),
              ),
              SizedBox(height: 13),
              TextFormField(
                controller: hospitalController,
                decoration: InputDecoration(
                  labelText: "Hospital Name",
                  hintText: "Hospital Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFFFC2CD)),
                  ),
                ),
              ),
              SizedBox(height: 13),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFFFC2CD)),
                  ),
                ),
              ),
              SizedBox(height: 13),
              ElevatedButton(
                onPressed: _addDoctor,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFC2CD)),
                ),
                child: Text(
                  "Add Doctor",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
