
// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/Dashborad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_dash.dart';
import 'Login_Page.dart';
import 'Profile_Page.dart';
import 'Signup_Page.dart';
import 'SplashScreen.dart';
import 'getStarted.dart';

class AuthController extends GetxController {
  //AuthController.instance..
  static AuthController instance = Get.find();
  //email, password, name ....
  late Rx<User?> _user;
  final auth = FirebaseAuth.instance;
  var verificationId = ''.obs;

  @override
  void onReady() {
    // super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges()); // to track user
    ever(_user, _initialScreens);
  }

  _initialScreens(User? user) {
    if (user == null) {
      print("Signup page");
      Get.offAll(() => SplashScreen());
    } else {
      Get.offAll(() => LoginPage());
    }
  }

    //
    // Future<void> phone(String phoneNo) async {
    //   try {
    //     await auth.verifyPhoneNumber(
    //       phoneNumber: phoneNo,
    //
    //       verificationCompleted: (credential) async {
    //         await auth.signInWithCredential(credential);
    //       },
    //       codeSent: (verificationId, resendToken) {
    //         print(phoneNo);
    //         this.verificationId.value = verificationId;
    //       },
    //       codeAutoRetrievalTimeout: (verificationId) {
    //         this.verificationId.value = verificationId;
    //       },
    //       verificationFailed: (e) {
    //         if (e.code == 'invalid-phone-number') {
    //           Get.snackbar('Error', 'The provided number is not valid');
    //         } else {
    //           print(phoneNo);
    //           Get.snackbar('Error', 'Verification failed. Please try again.');
    //         }
    //       },
    //     );
    //   } catch (e) {
    //     print("Firebase Phone Auth Error: $e");
    //     Get.snackbar('Error', 'Something went wrong. Please try again.');
    //   }
    // }


  //   Future<bool> verify(String otp) async{
  //   var credentials = await auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
  //   return credentials.user != null ? true : false;
  // }
  void register(String email, String password, String fname ,String lname,String nation, String num,String cnic) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password)
          .then((value) => {store(fname,lname,nation,num,cnic,email,)});
    } catch (e) {
      Get.snackbar("About User", "message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            "Invalid Email or Password!",
          ));
    }
  }

  void store( String fname, String lname, String nation, String cnic , String email,String num, ) async {
    var user = auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('Users');

    // Modify this line to include all the registration data
    ref.doc(user!.uid).set({
      'First Name': fname,
      'Last Name': lname,
      'Nationality': nation,
      'CNIC': cnic,
      'Email': email,
      'Phone Number': num,

    });

    Get.offAll(() => LoginPage());
  }

  // getUserid(){
  //   authStateChanges = auth.authStateChanges();
  //   authStateChanges.listen((User? user) {
  //     _users.value = user;
  //     id = user!.uid;
  //     print("User id ${id}");
  //   });

  // }

  void logIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => Home());
    } catch (e) {
      Get.snackbar("About Login", "message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
          ));
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
