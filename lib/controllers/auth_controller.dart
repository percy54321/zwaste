import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/sign_in.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  Future<void> signInWithGoogle() async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ));
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        // Sign in with Google
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Save user details to Firestore
        await _firestore
            .collection('users')
            .doc(userCredential.user!.email)
            .set({
          'email': userCredential.user!.email,
          'name': userCredential.user!.displayName,
          'phone_number':userCredential.user!.phoneNumber,
          'photo':userCredential.user!.photoURL,
          'uid':userCredential.user!.uid,

          // Add other desired user details
        });
      } on FirebaseAuthException catch (e) {
        Get.snackbar(
          "Error",
          e.message ?? "Unknown Error",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
    Get.back(); // Close the dialog
  }

  Future<void> signOut() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    await GoogleSignIn().signOut();

    Get.offAll(() => SignInScreen());
    await _auth.signOut();
    Get.back(); // Close the dialog
  }

  Future<void> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    final AccessToken? accessToken = result.accessToken;

    if (accessToken != null) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      try {
        await _auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        Get.snackbar(
          "Error",
          e.message ?? "Unknown Error",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
