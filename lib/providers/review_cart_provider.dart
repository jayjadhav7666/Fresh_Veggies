import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/model/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  //add data in review list
  void addReviewCartData({
    required String cartId,
    required String cartName,
    required String cartImage,
    required int cartPrice,
    required int cartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviwCart')
        .doc(cartId)
        .set({
      'cartId': cartId,
      'cartName': cartName,
      'cartImage': cartImage,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
      'isAdd': true,
    });
  }

// update data in review list
  void updateReviewCartData({
    required String cartId,
    required String cartName,
    required String cartImage,
    required int cartPrice,
    required int cartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviwCart')
        .doc(cartId)
        .update({
      'cartId': cartId,
      'cartName': cartName,
      'cartImage': cartImage,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
      'isAdd': true,
    });
  }

//get data in review list
  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot reviewcartdata = await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviwCart')
        .get();

    for (var element in reviewcartdata.docs) {
      newList.add(
        ReviewCartModel(
          cartId: element.get('cartId'),
          cartImage: element.get('cartImage'),
          cartName: element.get('cartName'),
          cartPrice: element.get('cartPrice'),
          cartQuantity: element.get('cartQuantity'),
        ),
      );
    }
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getreviewCartDataList {
    return reviewCartDataList;
  }

  //delete data in review list
  void deleteReviewData(String cartId) async {
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviwCart')
        .doc(cartId)
        .delete();

    notifyListeners();
  }
}
