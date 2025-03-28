import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/model/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  //add data in review list
  Future addReviewCartData({
    required String cartId,
    required String cartName,
    required String cartImage,
    required int cartPrice,
    required int cartQuantity,
    required var cartUnit,
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
      'cartUnit': cartUnit,
      'isAdd': true,
    });
    notifyListeners();
  }

// update data in review list
  Future updateReviewCartData({
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
    // getReviewCartData();
    notifyListeners();
  }

//get data in review list
  List<ReviewCartModel> reviewCartDataList = [];
  Future getReviewCartData() async {
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
          cartUnit: element.get('cartUnit'),
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
  Future deleteReviewData(String cartId) async {
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviwCart')
        .doc(cartId)
        .delete();
    notifyListeners();
  }

  ///total price
  getTotalPrice() {
    double total = 0.0;
    for (var element in reviewCartDataList) {
      total = total + (element.cartPrice * element.cartQuantity);
    }
    return total;
  }
}
