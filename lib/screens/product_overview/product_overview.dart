import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/providers/wistlist_provider.dart';
import 'package:fresh_veggies/screens/review_cart/review_cart.dart';
import 'package:fresh_veggies/widgets/count.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum SigninCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  final String productId;
  final String productName;
  final String productImage;
  final int productPrice;
  final String description;
  final int productQuantity;

  const ProductOverview({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.description,
    required this.productQuantity,
  });

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  SigninCharacter _character = SigninCharacter.fill;

  bool isFavourite = false;

  getFavouriteInfo() {
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWishList')
        .doc(widget.productId)
        .get()
        .then((value) {
      if (this.mounted) {
        if (value.exists) {
          setState(() {
            isFavourite = value.get('isFavourite');
          });
        }
      }
    });
  }

  Widget bottomNavigationBar(
      {required Color iconColor,
      required Color backgroundColor,
      required Color color,
      required String title,
      required IconData iconData,
      required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 15),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 25,
                color: iconColor,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: color,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    getFavouriteInfo();
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          bottomNavigationBar(
            iconColor: secondaryColor,
            color: secondaryColor,
            title: 'Add To Wishlist',
            backgroundColor: textColor,
            iconData:
                isFavourite == false ? Icons.favorite_outline : Icons.favorite,
            onTap: () {
              setState(() {
                isFavourite = !isFavourite;
              });

              if (isFavourite == true) {
                wishListProvider.addWishListData(
                  wishListId: widget.productId,
                  wishListName: widget.productName,
                  wishListImage: widget.productImage,
                  wishListPrice: widget.productPrice,
                  wishListQuantity: 2,
                );
              } else {
                wishListProvider.delete(widget.productId);
              }
            },
          ),
          bottomNavigationBar(
            iconColor: secondaryColor,
            color: secondaryColor,
            title: 'Go To Cart',
            backgroundColor: primaryColor,
            iconData: Icons.shopping_bag_outlined,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReviewCart(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: secondaryColor),
        title: Text(
          'Product Overview',
          style: GoogleFonts.manrope(
            color: secondaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Hero(
                tag: widget.productName,
                child: Text(
                  widget.productName,
                  style: GoogleFonts.manrope(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "\$${widget.productPrice}",
                style: GoogleFonts.manrope(
                  color: Colors.green[700],
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 250,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Image.network(
                  widget.productImage,
                ),
              ),
              Text(
                "Availabel Options",
                style: GoogleFonts.manrope(
                  color: textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.green[700],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Radio(
                        value: SigninCharacter.fill,
                        groupValue: _character,
                        activeColor: Colors.green[700],
                        onChanged: (value) {
                          setState(() {
                            _character = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    "\$50",
                    style: GoogleFonts.manrope(
                      color: textColorSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Count(
                    productName: widget.productName,
                    productImage: widget.productImage,
                    productId: widget.productId,
                    productPrice: widget.productPrice,
                    productQuantity: widget.productQuantity,
                  ),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(30),
                  //     border: Border.all(width: 1, color: textColorSecondary),
                  //   ),
                  //   child: Center(
                  //     child: Row(
                  //       children: [
                  //         Icon(
                  //           Icons.add,
                  //           size: 17,
                  //           color: primaryColor,
                  //         ),
                  //         const SizedBox(
                  //           width: 5,
                  //         ),
                  //         Text(
                  //           'ADD',
                  //           style: GoogleFonts.manrope(
                  //             fontWeight: FontWeight.w500,
                  //             color: primaryColor,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "About This Product",
                style: GoogleFonts.manrope(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
