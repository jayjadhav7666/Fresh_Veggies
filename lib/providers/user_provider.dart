import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  addUserData({
    required User currentUser,
    required String userName,
    required String userEmail,
    String? userImage,
  }) async {
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(currentUser.uid)
        .set({
      'userUid': currentUser.uid,
      'userName': userName,
      'userEmail': userEmail,
      'userImage': userImage ?? "",
    });
  }
}
