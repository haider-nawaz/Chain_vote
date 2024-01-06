import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:first/user_dash.dart';
import 'package:flutter/material.dart';
import 'Dashborad.dart';
import '/widgets/text_widget.dart';
import '/res/lists.dart';

import 'Chat.dart';

class SeeAll extends StatefulWidget {
  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  var opacity = 0.0;
  bool position=false;
  int selectedPageIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 40),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              top: position ? 1 : 50,
              left: 20,
              right: 20,
              child: upperRow(),
            ),

            AnimatedPositioned(
                top: position ? 100 : 250,
                left: 20,
                right: 20,
                duration: Duration(milliseconds: 500),
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity,
                    child: Container(
                      height: 350,
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder:
                            (context, index) => InkWell(
                          onTap: () async {
                            animator();
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Chat(image: images[index],name: names[index],specialist: spacilality[index]),
                                ));
                            animator();
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  const SizedBox(width: 20,),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: images[index],
                                    backgroundColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                        names[index],
                                        20,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                        spacilality[index],
                                        17,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,

                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.how_to_vote,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 20,),
                                ],
                              ),
                            ),
                          ),
                        ),),
                    )
                )),
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
    );
  }


  Widget upperRow(){
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              animator();
              Timer(const Duration(milliseconds: 600), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ));
              });
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
          TextWidget("Candidates", 25, Colors.black, FontWeight.bold),
          const Icon(
            Icons.search,
            color: Colors.black,
            size: 25,
          )
        ],
      ),
    );
  }

}
