import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/apis.dart';

/// A service class to handle Google Sign-In authentication.
class GoogleAuthService {
  /// Signs in the user using Google Sign-In and Firebase Authentication.
  ///
  /// Returns a [UserCredential] on successful sign-in,
  /// or `null` if sign-in fails or is cancelled by the user.
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // Step 1: Check internet connectivity
      await InternetAddress.lookup('google.com');

      // Step 2: Trigger the Google Sign-In prompt
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // User closed the sign-in popup

      // Step 3: Obtain authentication details from the Google account
      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // Step 4: Create a credential using Google token
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Step 5: Sign in to Firebase using the Google credentials
      return await APIs.auth.signInWithCredential(credential);

      
    } catch (e) {
      // Log the error in case of failure (e.g., no internet, auth error)
      log('Google Sign-In Error: $e');
      return null;
    }
  }
}
