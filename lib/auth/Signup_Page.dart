import 'package:cnic_scanner/cnic_scanner.dart';
import 'package:cnic_scanner/model/cnic_model.dart';
import 'package:first/na.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'Login_Page.dart';
import 'package:get/get.dart';
import '../auth_controller.dart';

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

  var selectedArea = "";
  var searchText = "";

  void _showAreaSelectionBottomSheet(BuildContext context) {
    generateDropdownItems();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final List<String> filteredAreas = [];
            if (searchText.isEmpty) {
              filteredAreas.addAll(areas2);
            } else {
              filteredAreas.addAll(
                areas2.where(
                  (area) =>
                      area.toLowerCase().contains(searchText.toLowerCase()),
                ),
              );
            }
            print("Filtered Areas: $filteredAreas");

            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search areas',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredAreas.length,
                      itemBuilder: (BuildContext context, int index) {
                        final area = filteredAreas[index];
                        return ListTile(
                          title: Text(area),
                          onTap: () {
                            Get.find<AuthController>().selectedArea.value =
                                area;
                            Navigator.pop(context, area);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<String> areas2 = [];

  void generateDropdownItems() {
    for (var naData in NADATA) {
      List<String> areas = naData['Areas'];
      print(areas);
      for (var area in areas) {
        areas2.add(area);
      }
    }
  }

  @override
  void initState() {
    //generateDropdownItems();

    // Loop through each NA's areas and add them to dropdown items

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    List images = ["g.png", "f.png"];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    var _value = "-1";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0),
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/log1.png"),
                        fit: BoxFit.cover)),
              ),
              Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Register your account",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              _showAreaSelectionBottomSheet(context);
                            },
                            child:
                                Get.find<AuthController>().selectedArea.value ==
                                        ""
                                    ? const Text("Select Area")
                                    : Text(
                                        Get.find<AuthController>()
                                            .selectedArea
                                            .value,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                          ),
                        ),
                        SizedBox(
                          width: w * 0.02,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              // CnicModel _cnicModel = CnicModel();

                              // final result = await CnicScanner()
                              //     .scanImage(imageSource: ImageSource.gallery);

                              // firstnameController.text =
                              //     result.cnicHolderName.split(" ")[0];
                              // lastnameController.text =
                              //     result.cnicHolderName.split(" ")[1];
                              // cnicController.text = result.cnicNumber;

                              //show dialog to select image from gallery or camera
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Select Image"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: const Text("Camera"),
                                          onTap: () async {
                                            final result = await CnicScanner()
                                                .scanImage(
                                                    imageSource:
                                                        ImageSource.camera);

                                            firstnameController.text = result
                                                .cnicHolderName
                                                .split(" ")[0];
                                            lastnameController.text = result
                                                .cnicHolderName
                                                .split(" ")[1];
                                            cnicController.text =
                                                result.cnicNumber;

                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: const Text("Gallery"),
                                          onTap: () async {
                                            final result = await CnicScanner()
                                                .scanImage(
                                                    imageSource:
                                                        ImageSource.gallery);

                                            firstnameController.text = result
                                                .cnicHolderName
                                                .split(" ")[0];
                                            lastnameController.text = result
                                                .cnicHolderName
                                                .split(" ")[1];
                                            cnicController.text =
                                                result.cnicNumber;

                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text("Scan CNIC")),
                      ],
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
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.4),
                          )
                        ]),
                    child: TextField(
                      controller: firstnameController,
                      decoration: InputDecoration(
                        hintText: "Full Name ",
                        prefixIcon:
                            Icon(Icons.person, color: Colors.green[600]),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0)),
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
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.4),
                          )
                        ]),
                    child: TextField(
                      controller: lastnameController,
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        prefixIcon:
                            Icon(Icons.person, color: Colors.green[600]),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0)),
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
                            offset: const Offset(1, 1),
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
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0)),
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
                            offset: const Offset(1, 1),
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
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0)),
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
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.4),
                            )
                          ]),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Your Email",
                          prefixIcon: Icon(Icons.email_outlined,
                              color: Colors.green[600]),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                        ),
                      )),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  //a drop down button that will show all the areas from NADATA
                  //type of NADATA is  List<Map<String, dynamic>>

                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: DropdownButton(
                  //     items: generateDropdownItems(),
                  //     value: selectedArea,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedArea = value.toString();
                  //       });
                  //     },
                  //   ),
                  // ),

                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.4),
                            )
                          ]),
                      child: TextField(
                        controller: numberController,
                        decoration: InputDecoration(
                          hintText: "Your Phone",
                          prefixIcon: Icon(Icons.phone_android,
                              color: Colors.green[600]),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
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
                              offset: const Offset(1, 1),
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
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                        ),
                      )),
                  SizedBox(
                    height: h * 0.02,
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  if (false) {
                    print("CNIC not Found");
                    // Display a Snackbar with an error message
                    Get.snackbar(
                      "About User",
                      "Invalid CNIC",
                      backgroundColor: Colors.redAccent,
                      snackPosition: SnackPosition.BOTTOM,
                      titleText: const Text(
                        "Account creation failed",
                        style: TextStyle(color: Colors.white),
                      ),
                      messageText: const Text(
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
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    // width: w * 0.1,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
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
                height: w * 0.04,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Login',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(
                                () => const LoginPage(),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Center(
              //   child: RichText(
              //       text: TextSpan(
              //     text: "Sign up using the following method",
              //     style: TextStyle(color: Colors.grey[500], fontSize: 16),
              //   )),
              // ),
              // // SizedBox(height: w*0.01,),
              // Center(
              //   child: Wrap(
              //     children: List<Widget>.generate(2, (index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(5.0),
              //         child: CircleAvatar(
              //           backgroundColor: Colors.white,
              //           radius: 30,
              //           child: CircleAvatar(
              //             backgroundColor: Colors.white,
              //             radius: 25,
              //             backgroundImage:
              //                 AssetImage("assets/" + images[index]),
              //           ),
              //         ),
              //       );
              //     }),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
