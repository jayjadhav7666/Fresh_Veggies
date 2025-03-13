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
  final String? productUnit;

  const Count({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productId,
    required this.productPrice,
    required this.productQuantity, this.productUnit,
  });

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isAdd = false;

  Future<void> getAddAndQuantity() async {
    DocumentSnapshot value = await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviwCart')
        .doc(widget.productId)
        .get();

    if (mounted) {
      setState(() {
        isAdd = value.exists ? value.get("isAdd") : false;
        count = value.exists ? value.get("cartQuantity") : 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAddAndQuantity();
  }

  @override
  Widget build(BuildContext context) {
    // getAddAndQuantity();
    // ReviewCartProvider reviewCartProvider =
    //     Provider.of<ReviewCartProvider>(context);
    return Consumer<ReviewCartProvider>(
      builder: (context, reviewCartProvider, child) {
        getAddAndQuantity();
        return Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: textColorSecondary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: isAdd == true
              ? Center(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          if (count > 1) {
                            setState(() {
                              count--;
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
                            reviewCartProvider
                                .deleteReviewData(widget.productId);

                            getAddAndQuantity();
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
                          if (count < 6) {
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
                          }
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
                        cartUnit:widget.productUnit,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
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
      },
    );
  }
}
