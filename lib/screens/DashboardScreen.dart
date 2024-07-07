import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pema_la/LocalStorage/SharedPref.dart';
import 'package:pema_la/global_variables.dart';
import 'package:pema_la/notification/noticationController.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int notificationCount = 0;
  void updateNotificationCount(int newCount) {
    setState(() {
      notificationCount = newCount;
    });
  }

  @override
  void initState() {
    SharedPref().getUserData();
    super.initState();
  }

  final NotificationController _notificationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back! $firstname'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: badges.Badge(
              showBadge: true,
              ignorePointer: false,
              badgeContent: Obx(() => Text(
                  _notificationController.notificationCount > 99
                      ? '99+'
                      : _notificationController.notificationCount.value
                          .toString(),
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold))),
              position: BadgePosition.topEnd(top: 0, end: 0),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(milliseconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.bounceInOut,
              ),
              badgeStyle: badges.BadgeStyle(
                padding: const EdgeInsets.all(2),
                borderRadius: BorderRadius.circular(4),
                shape: badges.BadgeShape.square,
                badgeColor: Color(0xFFF7E5E7),
                elevation: 0,
              ),
              child: IconButton(
                onPressed: () {
                  _notificationController.updateNotificationCount(0);
                  Navigator.pushNamed(context, '/Notification');
                },
                icon: const Icon(Icons.notifications, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body:
          // this container is for adding the color to the entire scaffold
          SingleChildScrollView(
        child: Container(
          color: Color(0xFFF7E5E7),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/Main.PNG',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 150, // Adjust position as needed
                    left: 25,
                    right: 30, // Adjust position as needed
                    child: Text(
                      'Nine months of joy a lifetime of love.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                        height:
                            8), // Optional: Add some spacing between text and icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/periodic");
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF7BD3EA),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.pregnant_woman,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Check Up",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/shop");
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.shopping_bag,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Shopping",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/todo");
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF29ADB2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.checklist,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Todo ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(seconds: 3),
                    viewportFraction: 0.8,
                    onPageChanged: (index, context) {},
                  ),
                  items: [
                    Image.asset(
                      'assets/images/P1.PNG',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/P2.PNG',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/P3.PNG',
                      fit: BoxFit.cover,
                    ),
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to another page when the card is tapped
                    Navigator.pushNamed(context, '/pdf');
                  },
                  child: Card(
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/stages.PNG",
                          width: 100,
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text("Know more about pregnancy"),
                        ),
                        // GestureDetector(
                        //     onTap: () {
                        //       Navigator.pushNamed(context, "/pdf");
                        //     },),
                      ],
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
