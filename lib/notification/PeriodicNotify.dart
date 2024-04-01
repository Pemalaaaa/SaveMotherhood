import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pema_la/notification/noticationController.dart';

class PerodicNotify extends StatefulWidget {
  const PerodicNotify({Key? key}) : super(key: key);

  @override
  State<PerodicNotify> createState() => _PerodicNotifyState();
}

class _PerodicNotifyState extends State<PerodicNotify> {
  late String eventName = "";
  late String eventPlace = "";
  late String eventDate = "";
  late String eventTime = "";
  late String eventDescription = "";
  final TextEditingController _name = TextEditingController();
  final TextEditingController _place = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);

  geteventName(name) {
    eventName = name;
  }

  getvisitPlace(place) {
    eventPlace = place;
  }

  getvisitDate(date) {
    eventDate = date;
  }

  getvisitTime(time) {
    eventTime = time;
  }

  geteventDescription(description) {
    eventDescription = description;
  }

  String createData() {
    DateTime? dateVal = dateSub.value;
    String formattedTime = _time.text;

    if (eventName.isNotEmpty &&
        eventPlace.isNotEmpty &&
        dateVal != null &&
        formattedTime.isNotEmpty &&
        eventDescription.isNotEmpty) {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("Checkup").doc(eventName);
      Map<String, dynamic> activity = {
        "eventName": eventName,
        "eventPlace": eventPlace,
        "eventDate": dateVal.toString(),
        "eventTime": formattedTime,
        "eventDescription": eventDescription
      };
      documentReference.set(activity);
      _name.clear();
      _place.clear();
      _date.clear();
      _time.clear();
      _description.clear();
      dateSub.value = null;
      return "Follow up has been added to list";
    } else {
      return "Please fill out all the fields";
    }
  }

  void showNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'added_event',
        title: eventName,
        body: eventDescription,
      ),
    );
  }

  void scheduleNotification(
      String eventName, String eventDescription, DateTime dateTime) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'event_reminder',
        title: eventName,
        body: eventDescription,
      ),
      schedule: NotificationCalendar(
        year: dateTime.year,
        month: dateTime.month,
        day: dateTime.day,
        hour: dateTime.hour,
        minute: dateTime.minute,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true,
      ),
    );
  }

  final NotificationController _notificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFFFFC2CD),
        centerTitle: true,
        title: const Text(
          'Check Up Schedule',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: activities(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (_name.text.isEmpty ||
              _place.text.isEmpty ||
              _date.text.isEmpty ||
              _time.text.isEmpty ||
              _description.text.isEmpty) {
            return;
          }

          // If all fields are filled, increment notification count and show notification
          setState(() {
            _notificationController.notificationCount++;
            showNotification();
          });

          // Schedule notification
          scheduleNotification(eventName, eventDescription, dateSub.value!);

          String message = createData();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Color(0xFFFFC2CD),
            ),
          );
        },
        child: const Text('Add Event'),
      ),
    );
  }

  Widget activities() {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
            ),
            const SizedBox(height: 15),

            // Follow up Name Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: 400,
              child: TextField(
                controller: _name,
                onChanged: (String name) {
                  geteventName(name);
                },
                decoration: InputDecoration(
                  hintText: 'Follow Up',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  prefixIcon: const Icon(Icons.medical_information , color: Color(0xFFFFC2CD)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Follow Up',
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Event Place Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: 400,
              child: TextField(
                controller: _place,
                onChanged: (String place) {
                  getvisitPlace(place);
                },
                decoration: InputDecoration(
                  hintText: 'Tokha, Kathmadu',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  prefixIcon: const Icon(Icons.place, color: Color(0xFFFFC2CD)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Location',
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Follow up Date Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _date,
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                    currentDate: DateTime.now(),
                    initialEntryMode: DatePickerEntryMode.calendar,
                    initialDatePickerMode: DatePickerMode.day,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch(
                            primarySwatch: Colors.blue,
                            accentColor: Colors.amber,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (selectedDate != null) {
                    setState(() {
                      dateSub.value = selectedDate;
                      _date.text = "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'YYYY/MM/DD',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  prefixIcon: const Icon(Icons.date_range, color: Color(0xFFFFC2CD)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Date',
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Event Time Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _time,
                readOnly: true,
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch(
                            primarySwatch: Colors.blue,
                            accentColor: Color(0xFFFFC2CD),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (selectedTime != null) {
                    final DateTime selectedDateTime = DateTime(
                      dateSub.value!.year,
                      dateSub.value!.month,
                      dateSub.value!.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                    dateSub.value = selectedDateTime;
                  }
                  _time.text = selectedTime != null ? selectedTime.format(context) : '';
                },
                decoration: InputDecoration(
                  hintText: 'hr/min',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  prefixIcon: const Icon(Icons.access_time, color: Color(0xFFFFC2CD)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Time',
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Check up Description Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _description,
                onChanged: (String description) {
                  geteventDescription(description);
                },
                decoration: InputDecoration(
                  hintText: 'Details of the report ',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  prefixIcon: const Icon(Icons.note, color: Color(0xFFFFC2CD)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Report Details',
                ),
                maxLines: 10, // Setting this to allow unlimited lines
                textInputAction: TextInputAction.newline, // Allowing user to insert line breaks
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ],
    );
  }
}
