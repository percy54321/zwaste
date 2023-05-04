import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerowaste/widgets/bottom_navigation.dart';
import 'controllers/auth_controller.dart';
import 'pages/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController _authController = Get.find();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter GetX Google Sign-In Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     
      home: Obx(() {
        if (_authController.firebaseUser.value != null) {
          return const BottomNavigation();
        } else {
          return SignInScreen();
        }
      }),
    );
  }
}
