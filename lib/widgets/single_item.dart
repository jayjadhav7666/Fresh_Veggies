import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/providers/review_cart_provider.dart';
import 'package:fresh_veggies/utils/utils.dart';
import 'package:fresh_veggies/widgets/count.dart';

import 'package:fresh_veggies/widgets/weight_sdr.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  final bool isBool;
  final String productId;
  final String productImage;
  final String productName;
  final int productPrice;
  final bool isFavourite;
  final int productQuantity;
  final VoidCallback? onDelete;
  const SingleItem(
      {super.key,
      this.isBool = false,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productId,
      required this.productQuantity,
      this.isFavourite = false,
      this.onDelete});

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  int? count;

  @override
  void initState() {
    super.initState();
    count = widget.productQuantity;
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.network(widget.productImage),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: widget.isBool
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '\$${widget.productPrice}',
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      widget.isBool
                          ? Text(
                              "50 Gram",
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            )
                          :   WeightDropdown(),
                    ],
                  ),
                ),
              ),
              widget.isBool
                  ? Column(
                      children: [
                        InkWell(
                          onTap: widget.onDelete,
                          child: Icon(
                            Icons.delete,
                            size: 25,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        (widget.isFavourite == false)
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      width: 1, color: textColorSecondary),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (count != null && count! > 1) {
                                            setState(() {
                                              count = count! - 1;
                                            });
                                            reviewCartProvider
                                                .updateReviewCartData(
                                              cartId: widget.productId,
                                              cartName: widget.productName,
                                              cartImage: widget.productImage,
                                              cartPrice: widget.productPrice,
                                              cartQuantity: count!,
                                            );
                                          } else {
                                            Utils.snackBar(
                                                'You reached the minimum limit',
                                                context);
                                          }
                                        },
                                        child: Icon(Icons.remove,
                                            size: 17, color: primaryColor),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '$count',
                                        style: GoogleFonts.manrope(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            count = (count ?? 0) + 1;
                                          });
                                          reviewCartProvider
                                              .updateReviewCartData(
                                            cartId: widget.productId,
                                            cartName: widget.productName,
                                            cartImage: widget.productImage,
                                            cartPrice: widget.productPrice,
                                            cartQuantity: count!,
                                          );
                                        },
                                        child: Icon(Icons.add,
                                            size: 17, color: primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )
                  : Count(
                      productName: widget.productName,
                      productImage: widget.productImage,
                      productId: widget.productId,
                      productPrice: widget.productPrice,
                      productQuantity: widget.productQuantity),
            ],
          ),
        ),
        if (widget.isBool) Divider(height: 1, color: Colors.grey[500]),
      ],
    );
  }
}
