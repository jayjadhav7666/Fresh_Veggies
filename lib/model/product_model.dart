class ProductModel {
  String productId;
  String productName;
  String productImage;
  String description;
  int productPrice;
  int productQuantity;

  ProductModel(
      {required this.productId,
      required this.productName,
      required this.productImage,
      required this.description,
      required this.productPrice,
      required this.productQuantity});
}
