import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> search = [];
  //for Herbs Seasoning Products
  List<ProductModel> herbsProductList = [];
  Future<void> fetchHerbsProduct() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("HerbsProduct").get();

    for (var element in value.docs) {
      ProductModel productModel = ProductModel(
        productId: element.get('productId'),
        productName: element.get("productName"),
        productImage: element.get("productImage"),
        description: element.get('description'),
        productPrice: element.get('productPrice'),
        productQuantity: 1,
      );
      newList.add(productModel);
    }
    herbsProductList = newList;
    updateSearchList();
    notifyListeners();
  }

  List<ProductModel> get getherbsProductsDataList {
    return herbsProductList;
  }

  //for Fresh Fruits Products
  List<ProductModel> fruitsproductList = [];

  Future<void> fetchFreshFruitsProduct() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FreshFruits").get();

    for (var element in value.docs) {
      ProductModel productModel = ProductModel(
        productId: element.get('productId'),
        productName: element.get("productName"),
        productImage: element.get("productImage"),
        description: element.get('description'),
        productPrice: element.get('productPrice'),
        productQuantity: 1,
      );
      newList.add(productModel);
    }
    fruitsproductList = newList;
    updateSearchList();
    notifyListeners();
  }

  List<ProductModel> get getfruitsProductsDataList {
    return fruitsproductList;
  }

  //for Root vegetables Products
  List<ProductModel> rootVegetablesproductList = [];

  Future<void> fetchrootvegetablesProduct() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("Root Vegetables").get();

    for (var element in value.docs) {
      ProductModel productModel = ProductModel(
        productId: element.get('productId'),
        productName: element.get("productName"),
        productImage: element.get("productImage"),
        description: element.get('description'),
        productPrice: element.get('productPrice'),
        productQuantity: 1,
      );
      newList.add(productModel);
    }
    rootVegetablesproductList = newList;
    updateSearchList();
    notifyListeners();
  }

  List<ProductModel> get getRootVegetablesProductsDataList {
    return rootVegetablesproductList;
  }

  //search
  void updateSearchList() {
    search = [
      ...herbsProductList,
      ...fruitsproductList,
      ...rootVegetablesproductList
    ];
  }

  List<ProductModel> get getSearchList {
    return search;
  }
}
