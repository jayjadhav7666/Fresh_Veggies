import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/model/product_model.dart';

class WishListProvider with ChangeNotifier {
  // add to wishList
  void addWishListData({
    required String wishListId,
    required String wishListName,
    required String wishListImage,
    required int wishListPrice,
    required int wishListQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWishList')
        .doc(wishListId)
        .set({
      'wishListId': wishListId,
      'wishListName': wishListName,
      'wishListImage': wishListImage,
      'wishListPrice': wishListPrice,
      'wishListQuantity': wishListQuantity,
      'isFavourite': true,
    });
  }
//get data from wishlist

  List<ProductModel> wishList = [];

  getWishtListData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .get();
    for (var element in value.docs) {
      ProductModel productModel = ProductModel(
        productId: element.get("wishListId"),
        productImage: element.get("wishListImage"),
        productName: element.get("wishListName"),
        productPrice: element.get("wishListPrice"),
        productQuantity: element.get("wishListQuantity"),
        description: '',
        productUnit: [],
      );
      newList.add(productModel);
    }
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishList {
    return wishList;
  }

  //delete data from wishList
  delete(String wishListId) async {
    await FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWishList')
        .doc(wishListId)
        .delete();
  }
}
