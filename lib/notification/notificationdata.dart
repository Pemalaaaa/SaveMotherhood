//calling data from firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';

class NotificationCheckUp extends StatefulWidget {
  const NotificationCheckUp({super.key});

  @override
  State<NotificationCheckUp> createState() => _NotificationCheckUpState();
}

final TextEditingController _name = TextEditingController();
final TextEditingController _place = TextEditingController();
final TextEditingController _date = TextEditingController();
final TextEditingController _time = TextEditingController();
final TextEditingController _description = TextEditingController();
final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);

void deleteData(String documentId) async {
  await FirebaseFirestore.instance
      .collection("Checkup")
      .doc(documentId)
      .delete();
}

class _NotificationCheckUpState extends State<NotificationCheckUp> {
  late String eventName = "";
  late String eventPlace = "";
  late String eventDate = "";
  late String eventTime = "";
  late String eventDescription = "";
  geteventName(name) {
    setState(() {
      eventName = name;
    });
  }

  geteventPlace(place) {
    setState(() {
      eventPlace = place;
    });
  }

  geteventDate(date) {
    setState(() {
      eventDate = date;
    });
  }

  geteventTime(time) {
    setState(() {
      eventTime = time;
    });
  }

  geteventDescription(description) {
    setState(() {
      eventDescription = description;
    });
  }

  updateData() async {
    DateTime? dateVal = dateSub.value;
    String formattedTime = _time.text;

    if (eventName.isNotEmpty &&
        eventPlace.isNotEmpty &&
        dateVal != null &&
        formattedTime.isNotEmpty) {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("Checkup").doc(eventName);
      Map<String, dynamic> activity = {
        "eventName": eventName,
        "eventPlace": eventPlace,
        "eventDate": dateVal.toString(),
        "eventTime": formattedTime,
        "eventDescription": eventDescription,
      };
      _name.clear();
      _place.clear();
      _date.clear();
      _time.clear();
      _description.clear();
      await documentReference.set(activity);
      return ("$activity updated");
    } else {
      return ("One or more fields are empty.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC2CD),
        title:  Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      //Editing Displayed Data Stored In Firebase
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Checkup").snapshots(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];

                return InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: AlertDialog(
                            title: const Text("Check Up Schedule",
                                style: TextStyle(color: Colors.black)),
                            content: Column(
                              // Edit Event Name
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  onChanged: (String name) {
                                    geteventName(name);
                                  },
                                  controller: _name,
                                  decoration: const InputDecoration(
                                      labelText: 'Follow Up'),
                                ),

                                //Edit Event Place
                                TextField(
                                  onChanged: (String place) {
                                    geteventPlace(place);
                                  },
                                  controller: _place,
                                  decoration: const InputDecoration(
                                      labelText: 'Hospital location'),
                                ),
                                const SizedBox(height: 10),

                                //Edit Event Date
                                ValueListenableBuilder<DateTime?>(
                                  valueListenable: dateSub,
                                  builder: (context, dateVal, child) {
                                    // Update the text field's controller when dateVal changes
                                    if (dateVal != null) {
                                      _date.text =
                                          "${dateVal.year}/${dateVal.month.toString().padLeft(2, '0')}/${dateVal.day.toString().padLeft(2, '0')}";
                                    }

                                    return SizedBox(
                                      height: 60,
                                      width: 180,
                                      child: TextField(
                                        onChanged: (String date) {
                                          geteventDate(date);
                                          _date.clear();
                                        },
                                        onTap: () async {
                                          DateTime? date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050),
                                            currentDate: DateTime.now(),
                                            initialEntryMode:
                                                DatePickerEntryMode.calendar,
                                            initialDatePickerMode:
                                                DatePickerMode.day,
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      ColorScheme.fromSwatch(
                                                    primarySwatch: Colors.blue,
                                                    accentColor: Colors.black,
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          dateSub.value = date;
                                        },
                                        controller: _date,
                                        decoration: InputDecoration(
                                          hintText: 'YYYY/MM/DD',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.date_range,
                                            color: Color(0xFFFFC2CD),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          label: const Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.0),
                                            child: Text("Date"),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                //Edit follow up schedule
                                ValueListenableBuilder<DateTime?>(
                                  valueListenable: dateSub,
                                  builder: (context, timeVal, child) {
                                    String formattedTime = timeVal != null
                                        ? TimeOfDay.fromDateTime(timeVal)
                                            .format(context)
                                        : '';

                                    _time.text = formattedTime;

                                    return SizedBox(
                                      height: 60,
                                      width: 180,
                                      child: TextField(
                                        onChanged: (String time) {
                                          geteventTime(time);
                                        },
                                        onTap: () async {
                                          TimeOfDay? selectedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      ColorScheme.fromSwatch(
                                                   // primarySwatch: Colors.red,
                                                    accentColor:Color(0xFFFFC2CD),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );

                                          if (selectedTime != null) {
                                            DateTime selectedDateTime =
                                                DateTime(
                                              timeVal?.year ??
                                                  DateTime.now().year,
                                              timeVal?.month ??
                                                  DateTime.now().month,
                                              timeVal?.day ??
                                                  DateTime.now().day,
                                              selectedTime.hour,
                                              selectedTime.minute,
                                            );
                                            dateSub.value = selectedDateTime;
                                            // _time.text =
                                            //     selectedTime.format(context);
                                          }
                                        },
                                        readOnly: true,
                                        controller: _time,
                                        decoration: InputDecoration(
                                          hintText: 'hr/min',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.access_time,
                                            color: Color(0xFFFFC2CD),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          label: const Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.0),
                                            child: Text("Time"),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                //Edit Event Description
                                TextField(
                                  onChanged: (String description) {
                                    geteventDescription(description);
                                  },
                                  controller: _description,
                                  decoration: const InputDecoration(
                                      labelText: 'Description'),
                                ),
                              ],
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    child: const Text("Cancel",
                                        style: TextStyle(color: Color(0xFFFFC2CD))),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                     color: Color(0xFFFFC2CD)
                                    ),
                                    onPressed: () {
                                      updateData();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Color(0xFFFFC2CD)
                                    ),
                                    onPressed: () {
                                      deleteData(documentSnapshot
                                          .id); // Call your delete function here
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },

                  //Displaying Data Contained in Firebase
                  //Collection of Stored Data in List
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                        color: Color(0xFFF7E5E7),
                        borderRadius: BorderRadius.circular(12)),

                    //Event Name Filed Display
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        children: [
                          const Text(
                            "Follow Up            : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventName"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),

                      //Event Place Filed Display
                      Row(
                        children: [
                          const Text(
                            "Location              : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventPlace"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),

                      //Event Date Filed Display
                      Row(
                        children: [
                          const Text(
                            "Date                     : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventDate"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),

                      //Event Time Filed Display
                      Row(
                        children: [
                          const Text(
                            "Time                    : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventTime"].toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),

                      //Event Description Filed Display
                      Row(
                        children: [
                          const Text(
                            "Description         : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventDescription"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                    ]),
                  ),
                );
              },
            );
          } else {
            return const Align(
              alignment: FractionalOffset.bottomCenter,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
