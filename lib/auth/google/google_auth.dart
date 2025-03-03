import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/data/api_exception.dart';
import 'package:fresh_veggies/providers/user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleAuthentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> signWithGoogle(BuildContext context) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      //start google sign-in
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return null;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(authCredential);
      final User? user = userCredential.user;

      if (user == null) {
        return null;
      }
      await userProvider.addUserData(
          currentUser: user,
          userName: user.displayName ?? 'No name',
          userEmail: user.email ?? 'No Email',
          userImage: user.photoURL);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      log(error.toString());
      throw FetchDataException(error.message ?? "Authentication error.");
    } catch (e) {
      log("Error: $e");
      throw GoogleSignInFailedException();
    }
  }

  googleSignOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }
}
