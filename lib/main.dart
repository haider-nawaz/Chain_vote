import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first/Dashborad.dart';
import 'package:first/SplashScreen.dart';
import 'package:first/auth/Login_Page.dart';
import 'package:flutter/material.dart';
// import 'dart:js';

import 'package:get/get.dart';
import 'auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));

  // await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //FirebaseAuth.instance.signOut();
    final user = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      // home: new LoginScreen(),
      debugShowCheckedModeBanner: false,
      home: user == null ? const LoginPage() : const LoginPage(),
    ); //MaterialApp
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/error_codes.dart' as error_code;
// import 'package:local_auth/local_auth.dart';
// import 'package:local_auth_android/local_auth_android.dart';
// import 'package:local_auth_ios/local_auth_ios.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool isDeviceSupport = false;
//   bool authenticated = false;
//   List<BiometricType>? availableBiometrics;
//   LocalAuthentication? auth;

//   @override
//   void initState() {
//     super.initState();

//     auth = LocalAuthentication();

//     deviceCapability();
//     _getAvailableBiometrics();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.black45,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             if (isDeviceSupport)
//               Text(
//                 "Fingerprint Verified",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold),
//               ),
//             SizedBox(
//               height: h * 0.02,
//             ),
//             // Icon(Icons.fingerprint,size: 50,color: Colors.white,)
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _getAvailableBiometrics() async {
//     try {
//       availableBiometrics = await auth?.getAvailableBiometrics();
//       print("bioMetric: $availableBiometrics");

//       if (availableBiometrics!.contains(BiometricType.strong) ||
//           availableBiometrics!.contains(BiometricType.fingerprint)) {
//         authenticated = true;
//         final bool didAuthenticate = await auth!.authenticate(
//             localizedReason: 'Unlock with fingerprint',
//             options: const AuthenticationOptions(
//                 biometricOnly: true, stickyAuth: true),
//             authMessages: const <AuthMessages>[
//               AndroidAuthMessages(
//                 signInTitle: 'Fingerprint Verification',
//                 cancelButton: 'No thanks',
//               ),
//               IOSAuthMessages(
//                 cancelButton: 'No thanks',
//               ),
//             ]);
//         if (!didAuthenticate) {
//           exit(0);
//         }
//       } else if (availableBiometrics!.contains(BiometricType.weak) ||
//           availableBiometrics!.contains(BiometricType.face)) {
//         authenticated = true;
//         final bool didAuthenticate = await auth!.authenticate(
//             localizedReason: 'Unlock with Face lock',
//             options: const AuthenticationOptions(stickyAuth: true),
//             authMessages: const <AuthMessages>[
//               AndroidAuthMessages(
//                 signInTitle: 'Unlock Ideal Group',
//                 cancelButton: 'No thanks',
//               ),
//               IOSAuthMessages(
//                 cancelButton: 'No thanks',
//               ),
//             ]);
//         if (!didAuthenticate) {
//           exit(0);
//         }
//       }
//     } on PlatformException catch (e) {
//       // availableBiometrics = <BiometricType>[];
//       if (e.code == error_code.passcodeNotSet) {
//         exit(0);
//       }
//       print("error: $e");
//     }
//   }

//   void deviceCapability() async {
//     final bool isCapable = await auth!.canCheckBiometrics;
//     isDeviceSupport = isCapable || await auth!.isDeviceSupported();
//   }
// }
