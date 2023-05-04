import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              CircleAvatar(
                radius: 40,
                backgroundImage: CachedNetworkImageProvider(
                  _authController.firebaseUser.value?.photoURL ??
                      "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                ),
              ),
              SizedBox(height: 16),
              Text(
                _authController.firebaseUser.value?.displayName ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                _authController.firebaseUser.value?.email ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    "Settings",
                    style: GoogleFonts.poppins(),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ),
              SizedBox(height: 8),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text(
                    "Help",
                    style: GoogleFonts.poppins(),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ),
              SizedBox(height: 8),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                    "Sign Out",
                    style: GoogleFonts.poppins(),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _authController.signOut();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
