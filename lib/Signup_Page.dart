
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Login_Page.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();
  final cnicController = TextEditingController();
  final nationalityController = TextEditingController();
  final lastnameController = TextEditingController();
  final firstnameController = TextEditingController();

  List<String> cniccheck = [
    "12345",
    "54321",
    "24689",
    // Add more CNIC numbers as needed
  ];


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List images = ["g.png", "f.png"];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    var _value = "-1";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0),
            width: w * 0.5,
            height: h * 0.2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/log1.png"), fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Register your account",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.4),
                        )
                      ]),
                  child: TextField(
                    controller: firstnameController,
                    decoration: InputDecoration(
                      hintText: "Full Name ",
                      prefixIcon: Icon(Icons.person, color: Colors.green[600]),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.4),
                        )
                      ]),
                  child: TextField(
                    controller: lastnameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      prefixIcon: Icon(Icons.person, color: Colors.green[600]),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.4),
                        )
                      ]),
                  child: TextField(
                    controller: nationalityController,
                    decoration: InputDecoration(
                      hintText: "Nationality ",
                      prefixIcon:
                          Icon(Icons.add_home, color: Colors.green[600]),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.4),
                        )
                      ]),
                  child: TextField(
                    controller: cnicController,
                    decoration: InputDecoration(
                      hintText: "CNIC",
                      prefixIcon:
                          Icon(Icons.numbers_sharp, color: Colors.green[600]),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),

                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.4),
                          )
                        ]),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Your Email",
                        prefixIcon:
                            Icon(Icons.email_outlined, color: Colors.green[600]),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                      ),
                    )),
                SizedBox(
                  height: h * 0.02,
                ),

                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.4),
                          )
                        ]),
                    child: TextField(
                      controller: numberController,
                      decoration: InputDecoration(
                        hintText: "Your Phone",
                        prefixIcon:
                            Icon(Icons.phone_android, color: Colors.green[600]),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                      ),
                    )),
                SizedBox(
                  height: h * 0.02,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.4),
                          )
                        ]),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon:
                            Icon(Icons.password, color: Colors.green[600]),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                      ),
                    )),
                SizedBox(
                  height: h * 0.02,
                ),
              ],
            ),
          ),
          SizedBox(
            height: h * 0.03,
          ),
          GestureDetector(
            onTap: () {
              if (!cniccheck.contains(cnicController.text)) {
                print("CNIC not Found");
                // Display a Snackbar with an error message
                Get.snackbar(
                  "About User",
                  "Invalid CNIC",
                  backgroundColor: Colors.redAccent,
                  snackPosition: SnackPosition.BOTTOM,
                  titleText: Text(
                    "Account creation failed",
                    style: TextStyle(color: Colors.white),
                  ),
                  messageText: Text(
                    "Invalid CNIC!",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                // CNIC matches, proceed with registration
                AuthController.instance.register(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  firstnameController.text.trim(),
                  lastnameController.text.trim(),
                  nationalityController.text.trim(),
                  numberController.text.trim(),
                  cnicController.text.trim(),
                );
              }
            },
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                width: w * 0.1,
                height: h * 0.09,
                decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: w * 0.01,
          ),
          Center(
            child: RichText(
                text: TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.to(() => LoginPage()))),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RichText(
                text: TextSpan(
              text: "Sign up using the following method",
              style: TextStyle(color: Colors.grey[500], fontSize: 16),
            )),
          ),
          // SizedBox(height: w*0.01,),
          Center(
            child: Expanded(
              child: Wrap(
                children: List<Widget>.generate(2, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                        backgroundImage: AssetImage("assets/" + images[index]),
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
