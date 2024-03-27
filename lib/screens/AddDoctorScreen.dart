import 'package:flutter/material.dart';
import 'package:pema_la/models/DoctorData.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
//controller is used for storing the data of the doctor
  TextEditingController nameController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  //initiating a empty list
  List<Doctor> doctors = [];

  //making a function whereas it is also inheritance concept
  void _addDoctor() {
    Doctor doctor = Doctor(
        name: nameController.text,
        hospital: hospitalController.text,
        phone: phoneController.text);

    setState(() {
      doctors.add(doctor);
      // so in order to clear the textfield after
      //adding the clear method is used by calling in each text controller to reset empty
      nameController.clear();
      hospitalController.clear();
      phoneController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC2CD),
        title: Text("Add Doctors"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/view",
                    arguments:
                        doctors); // navigating to the the view eye ma and carries the detail arguments: students form students where the maes were add in the list (pass to viewStudent)
              },
              icon: Icon(Icons.remove_red_eye))
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
            SizedBox(
              height: 13,
            ),
            TextFormField(
              controller: hospitalController,
              decoration: InputDecoration(
                labelText: "Hospital Name",
                hintText: "Hospital Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFFFC2CD))
                  ),
                  ),
            ),
            SizedBox(
              height: 13,
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFFFC2CD))
                  ),
                ),
            ),
            SizedBox(
              height: 13,
            ),
            ElevatedButton(
                onPressed: () {
                  _addDoctor();
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFFFC2CD))),
                child: Text(
                  "Add Doctors",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ))
          ],
        ),
      )),
    );
  }
}
