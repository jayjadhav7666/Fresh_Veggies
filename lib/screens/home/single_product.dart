import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/count.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleProduct extends StatefulWidget {
  final String productId;
  final String productImage;
  final String productName;
  final int productPrice;
  final VoidCallback onTap;
  const SingleProduct(
      {super.key,
      required this.productImage,
      required this.productName,
      required this.onTap,
      required this.productPrice,
      required this.productId});

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 190,
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
                  height: 100,
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
                  '\$${widget.productPrice}',
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: textColorSecondary),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              '50 Gram',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: textColorSecondary,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 17,
                              color: primaryColor,
                            ),
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
                      productQuantity: 1,
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
