import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Nancy !"), actions: [
        IconButton(
          icon: Icon(Icons.notification_add),
          onPressed: () {},
        )
      ]),
      body:
          // this container is for adding the color to the entire scaffold
          Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/articles');
                    },
                   
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(
                                0xFF7BD3EA), // Background color of the box
                            borderRadius: BorderRadius.circular(
                                10.0), // Border radius to create rounded corners
                          ),

                          padding: EdgeInsets.all(10.0),

                          // Padding inside the box
                          child: Icon(
                            Icons.pregnant_woman,
                            size: 30.0,
                            color: Colors.white,

                            // Color of the icon
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Articles",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.black),
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
                            color: Colors.blue, // Background color of the box
                            borderRadius: BorderRadius.circular(
                                10.0), // Border radius to create rounded corners
                          ),

                          padding: EdgeInsets.all(10.0),

                          //  Padding inside the box
                          child: Icon(
                            Icons.shopping_bag,
                            size: 30.0,
                            color: Colors.white, // Color of the icon
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Shopping",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.black),
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
                            color: Color(0xFF29ADB2
                            ), // Background color of the box
                            borderRadius: BorderRadius.circular(
                                10.0), // Border radius to create rounded corners
                          ),

                          padding: EdgeInsets.all(10.0),

                          // Padding inside the box
                          child: Icon(
                            Icons.checklist,
                            size: 30.0,
                            color: Colors.white, // Color of the icon
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Todo ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
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
                    )
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
