import 'dart:async';

import 'package:first/user_dash.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Profile_Page.dart';
import 'SeeAll.dart';
import '/res/lists.dart';
import '/widgets/text_widget.dart' ;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var opacity = 0.0;
  bool position = false;
  String selectedFeature = '';
  int selectedPageIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();

      setState(() {

      });
    });
  }
  animator() {
    if (opacity == 1) {
      opacity = 0;
      position=false;
    } else {
      opacity = 1;
      position=true;
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30, left: 0, right:0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 100,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget("Hello", 17, Colors.black.withOpacity(.7),
                              FontWeight.bold),
                          TextWidget("Giovanny", 25, Colors.black, FontWeight.bold),
                        ],
                      ),
                      const Icon(Icons.phonelink_ring )
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                top: position ? 80 : 140,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search_sharp,
                            size: 30,
                            color: Colors.black.withOpacity(.5),
                          ),
                          hintText: "   Search"),
                    ),
                  ),
                ),
              ),
              featureButtonsRow(),

              AnimatedPositioned(
                  top: position ? 200 : 220,

                  left: 20,
                  right: 20, duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget("Candidates", 25, Colors.black.withOpacity(.8), FontWeight.bold,letterSpace: 0,),
                      InkWell(
                        onTap: () async
                          {
                            animator();
                            setState(() {
                            });
                            // Timer(Duration(seconds: 1),() {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll(),));
                            //   animator();
                            // },);
                            await Future.delayed(const Duration(milliseconds: 500));
                            await Navigator.push(context, MaterialPageRoute(builder:  (context) {
                              return SeeAll();
                            },));

                            setState(() {
                              animator();
                            });
                          },
                          child: TextWidget("See all", 15, Colors.blue.shade600.withOpacity(.8), FontWeight.bold,letterSpace: 0,)),
                    ],
                ),
              ),
                  )),
              candidateList(),

              // Bottom buttons
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: CurvedNavigationBar(
                    backgroundColor: Colors.white,
                    index: selectedPageIndex,
                    items: [
                      Icon(Icons.home_filled, color: selectedPageIndex == 0 ? Colors.green : Colors.black, size: 30),
                      Icon(Icons.how_to_vote, color: selectedPageIndex == 1 ? Colors.green : Colors.black, size: 30),
                      Icon(Icons.account_circle_outlined, color: selectedPageIndex == 2 ? Colors.green : Colors.black, size: 30),
                    ],
                    onTap: (index) {
                      setState(() {
                        selectedPageIndex = index;
                      });
                      if (index == 0) {
                        // Navigate to Home.dart
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAll(),
                          ),
                        );
                        // Stay on this page (SeeAll.dart)
                      } else if (index == 2) {
                        // Navigate to Profile page
                        // You can replace 'ProfilePage()' with your actual profile page widget
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDashboard(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget candidateList() {
    return AnimatedPositioned(
      top: position ? 260 : 250,
      left: 20,
      right: 20,
      duration: const Duration(milliseconds: 400),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  candidateCard("Nitrate", "PMLN", AssetImage('assets/images/team01.jpg')),
                  candidateCard("Shariq", "PTI", AssetImage('assets/images/ik.jpeg')),
                  candidateCard("Husnain", "PPL", AssetImage('assets/images/ali.jpeg')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget candidateCard(String name, String party, AssetImage image) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 10,),
            CircleAvatar(
              radius: 30,
              backgroundImage: image,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  party,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.how_to_vote, color: Colors.green,),
            const SizedBox(width: 20,),
          ],
        ),
      ),
    );
  }


  Widget featureButtonsRow() {
    return AnimatedPositioned(
      top: position ? 150 : 220,
      left: 20,
      right: 20,
      duration: const Duration(milliseconds: 400),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            featureButton("ONGOING"),
            featureButton("Governorship"),

          ],
        ),
      ),
    );
  }

  Widget featureButton(String label) {
    bool isSelected = label == selectedFeature;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFeature = label;
        });
        // Implement the specific behavior for each feature button
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black; // Change color when button is pressed
            } else if (isSelected) {
              return Colors.green; // Change color when button is selected
            } else {
              return Colors.white; // Default color
            }
          },
        ),
        elevation: MaterialStateProperty.all<double>(4), // Add shadow
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16, color: Colors.black), // Text color
      ),

    );
  }


}
