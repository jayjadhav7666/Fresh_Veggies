import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/data/api_exception.dart';
import 'package:fresh_veggies/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up with Email & Password
  Future<UserCredential?> signUpWithEmail(
      String name, String email, String password, BuildContext context) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userProvider.addUserData(
        currentUser: userCredential.user!,
        userName: name,
        userEmail: email,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw FetchDataException('Authentication failed. Try again.');
    }
  }

  // Sign In with Email & Password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw FetchDataException('Authentication failed. Try again.');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Handle FirebaseAuthException
  ApiException _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-credential":
        return BadRequestException('Invail Email & Password');
      case "user-not-found":
        return UnauthorizedException('User Not Found');
      case "wrong-password":
        return UnauthorizedException(
            'Wrong Passoword, Please Enter Correct Password');
      case 'network-request-failed':
        return InternetException('No Internet Connection');
      case "invalid-email":
        return BadRequestException('Email Already In Use');
      case 'too-many-requests':
        return RequestTimeOut('Too many request please try after some time.');
      default:
        log(e.code);
        return FetchDataException(e.code);
    }
  }
}
