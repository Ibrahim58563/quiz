import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/authentication/loginPage.dart';
import 'package:quiz_app/screens/main_screen.dart';
import 'package:quiz_app/screens/welcomePage.dart';

class AuthService {
  // 1. handle Auth State

  // 2. sign in

  // 3. sign out

  handleAuthState() {
    return StreamBuilder(builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        return const MainScreen();
      } else {
        return WelcomePage();
      }
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
