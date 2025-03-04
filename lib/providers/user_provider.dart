import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/model/user_model.dart';

class UserProvider with ChangeNotifier {
  //add userData
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

//update userData
  updateUserData({
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
      'userImage': userImage,
    });
  }

//get userData
  late UserModel userModel;
  getUserData() async {
    var value = await FirebaseFirestore.instance
        .collection('UserData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get('userEmail'),
        userName: value.get('userName'),
        userImage: value.get('userImage'),
        userUid: value.get('userUid'),
      );
      notifyListeners();
    }
  }

  UserModel get getUserInfo {
    return userModel;
  }
}
