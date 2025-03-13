import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/providers/review_cart_provider.dart';
import 'package:fresh_veggies/utils/utils.dart';
import 'package:fresh_veggies/widgets/count.dart';
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
  final VoidCallback? onTap;
  final String? cartUnit;
  final List<dynamic>? productUnit;
  const SingleItem({
    super.key,
    this.isBool = false,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.productQuantity,
    this.isFavourite = false,
    this.onDelete,
    this.onTap,
    this.cartUnit,
    this.productUnit,
  });

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late String unitData;
  @override
  @override
  void initState() {
    super.initState();

    if (widget.cartUnit != null && widget.cartUnit!.isNotEmpty) {
      unitData = widget.cartUnit!;
    } else if (widget.productUnit != null && widget.productUnit!.isNotEmpty) {
      unitData = widget.productUnit![0];
    } else {
      unitData = "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
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
                            '${widget.productPrice}\$',
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
                              widget.cartUnit ?? '',
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            )
                          : Container(
                              height: 35,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: textColorSecondary),
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
                                  return widget.productUnit!
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
                            ? Consumer<ReviewCartProvider>(
                                builder: (context, reviewCartProvider, child) {
                                  int count = widget.productQuantity;
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: textColorSecondary),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (count > 1) {
                                                setState(() {
                                                  count--;
                                                });
                                                reviewCartProvider
                                                    .updateReviewCartData(
                                                  cartId: widget.productId,
                                                  cartName: widget.productName,
                                                  cartImage:
                                                      widget.productImage,
                                                  cartPrice:
                                                      widget.productPrice,
                                                  cartQuantity: count,
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
                                                count++;
                                              });
                                              reviewCartProvider
                                                  .updateReviewCartData(
                                                cartId: widget.productId,
                                                cartName: widget.productName,
                                                cartImage: widget.productImage,
                                                cartPrice: widget.productPrice,
                                                cartQuantity: count,
                                              );
                                            },
                                            child: Icon(Icons.add,
                                                size: 17, color: primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(),
                      ],
                    )
                  : Count(
                      productName: widget.productName,
                      productImage: widget.productImage,
                      productId: widget.productId,
                      productPrice: widget.productPrice,
                      productQuantity: widget.productQuantity,
                    ),
            ],
          ),
        ),
        if (widget.isBool) Divider(height: 1, color: Colors.grey[500]),
      ],
    );
  }
}
