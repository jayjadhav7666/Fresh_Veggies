import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/providers/review_cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productId;
  final int productPrice;
  final int productQuantity;

  const Count(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.productId,
      required this.productPrice,
      required this.productQuantity});

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isAdd = false;

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviwCart')
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isAdd = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);
    getAddAndQuantity();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: textColorSecondary),
        borderRadius: BorderRadius.circular(20),
      ),
      child: isAdd == true
          ? Center(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (count > 1) {
                        setState(() {
                          count++;
                        });
                        reviewCartProvider.updateReviewCartData(
                          cartId: widget.productId,
                          cartName: widget.productName,
                          cartImage: widget.productImage,
                          cartPrice: widget.productPrice,
                          cartQuantity: count,
                        );
                      } else {
                        setState(() {
                          isAdd = false;
                        });
                        reviewCartProvider.deleteReviewData(widget.productId);
                      }
                    },
                    child: Icon(
                      Icons.remove,
                      size: 18,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$count',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartName: widget.productName,
                        cartImage: widget.productImage,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                      );
                    },
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isAdd = true;
                  });
                  reviewCartProvider.addReviewCartData(
                    cartId: widget.productId,
                    cartName: widget.productName,
                    cartImage: widget.productImage,
                    cartPrice: widget.productPrice,
                    cartQuantity: count,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'ADD',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
