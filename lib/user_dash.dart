import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'Dashborad.dart';
import 'SeeAll.dart';
import 'auth_controller.dart';
class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();

}

class _UserDashboardState extends State<UserDashboard> {
  var opacity = 0.0;
  bool position = false;
  String selectedFeature = '';
  int selectedPageIndex = 1;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed:()=> Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            )),icon: const Icon(Icons.arrow_back, color: Colors.greenAccent)),
        title: Text("Profile"),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(left: 25,right: 25),
          child: Column(
            children: [
              SizedBox(height: h*0.05,),
              Center(
                child: Container(
                  width: w*0.3,
                  height: h*0.14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: AssetImage(
                              "img/pexels-tima-miroshnichenko-5407206.jpg"
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.012,),
              Text(
                "User Name..",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: h*0.035,),
              GestureDetector(
                onTap: (){
                  // Get.to(Doctor_Profile());
                },
                child: Container(
                    width: w*0.45,
                    height: h*0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 4,
                            offset: Offset(1, 1),
                            color:Colors.grey.withOpacity(0.5),
                          )
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.green,
                            Colors.green,
                          ],
                        )
                      // image: DecorationImage(
                      //   image: AssetImage(
                      //       "img/btn.jpg"
                      //   ),
                      //   fit: BoxFit.cover,
                      // )
                    ),
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                ),
              ),
              SizedBox(height: h*0.05,),

              ProfileManage(title:"My Profile",icon: Icons.person,onPress:(){
                // Get.to(Doctor_Page());
              }),

              Divider(
                color: Colors.grey,
              ),
              ProfileManage(title:"Setting",icon: Icons.settings,onPress:(){}),
              ProfileManage(title:"Logout",icon: Icons.logout,endIcon: false, onPress:(){
                AuthController.instance.logOut();
              }),
            ],
          ),
        ),
      ),
    );
  }
}


class ProfileManage extends StatelessWidget {
  const ProfileManage({
    Key?key,
    required this.title,
    required this.icon,
    this.endIcon = true,
    required this.onPress,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final bool endIcon;
  final VoidCallback onPress;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.tealAccent.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.green[600]),
      ),
      title: Text(title),
      trailing: endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.tealAccent.withOpacity(0.1),
        ),
        child: Icon(Icons.keyboard_arrow_right, color: Colors.green[600]),
      ): null,
    );
  }

}