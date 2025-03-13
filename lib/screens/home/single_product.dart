import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/model/product_model.dart';
import 'package:fresh_veggies/widgets/count.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleProduct extends StatefulWidget {
  final String productId;
  final String productImage;
  final String productName;
  final int productPrice;
  final VoidCallback onTap;
  final ProductModel productUnit;
  const SingleProduct({
    super.key,
    required this.productImage,
    required this.productName,
    required this.onTap,
    required this.productPrice,
    required this.productId,
    required this.productUnit,
  });

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  int count = 0;

  late String unitData;
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
                    })
                  }
              }
          },
        );
  }

  @override
  void initState() {
    super.initState();
    unitData = widget.productUnit.productUnit[0];
  }

  @override
  Widget build(BuildContext context) {
    // getAddAndQuantity();
    log('single product');
    return Container(
      height: 240,
      width: 200,
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 7),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Color.fromRGBO(239, 239, 244, 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Center(
              child: Hero(
                tag: widget.productImage,
                child: Image.network(
                  widget.productImage,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                Text(
                  '${widget.productPrice}\$/$unitData',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColorSecondary,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: textColorSecondary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: PopupMenuButton<String>(
                        padding: const EdgeInsets.all(12),
                        borderRadius: BorderRadius.circular(20),
                        color: whiteColor,
                        onSelected: (value) {
                          setState(() {
                            unitData = value;
                          });
                        },
                        itemBuilder: (context) {
                          return widget.productUnit.productUnit
                              .cast<String>()
                              .map((String weight) {
                            return PopupMenuItem<String>(
                              value: weight,
                              child: Text(
                                weight,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: textColorSecondary,
                                ),
                              ),
                            );
                          }).toList();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              unitData,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: textColorSecondary,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(Icons.arrow_drop_down,
                                size: 17, color: primaryColor),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Count(
                      productId: widget.productId,
                      productName: widget.productName,
                      productImage: widget.productImage,
                      productPrice: widget.productPrice,
                      productQuantity: count,
                      productUnit: unitData,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
