import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../controllers/auth_controller.dart';
import '../widgets/bottom_navigation.dart';

class SignInScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/bk.jpg'),
          fit: BoxFit.cover,
        )),
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 130,
                      width: 130,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Lasbite Zero Waste',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    const Text(
                      'Sign in to your account to continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    buildSignInOption(
                      title: 'Sign In With Google',
                      onTap: () async {
                        try {
                          await _authController.signInWithGoogle();
                          Get.offAll(() => const BottomNavigation());
                        } catch (e) {
                          print(e.toString());
                          Get.snackbar(
                            "Error",
                            e.toString(),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              TextButton(
                onPressed: () async {
                  // TODO: Implement Facebook sign-in
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48.0,
                    vertical: 12.0,
                  ),
                ),
                child: const Text(
                  'Sign in with Facebook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSignInOption({
    VoidCallback? onTap,
    String? title,
    Color? color,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          width: 240,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/google_icon.png',
                  height: 20,
                  width: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  title!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
