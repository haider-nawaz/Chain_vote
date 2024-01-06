import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'dart:js';

import 'package:get/get.dart';
import 'SplashScreen.dart';
import 'auth_controller.dart';

import 'firebase_options.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthController()));
  // await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      // home: new LoginScreen(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );//MaterialApp
  }
}
