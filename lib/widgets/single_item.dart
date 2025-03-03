import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/providers/review_cart_provider.dart';
import 'package:fresh_veggies/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  final bool isBool;
  final String productId;
  final String productImage;
  final String productName;
  final int productPrice;
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
      this.onDelete});

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  int? count;

  @override
  void initState() {
    super.initState();
    count = widget.productQuantity; // Initialize count
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
                          : Container(
                              width: 85,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: textColorSecondary),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      '50 Gram',
                                      style: GoogleFonts.manrope(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: textColorSecondary,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 17,
                                      color: primaryColor,
                                    ),
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
                          child: Icon(Icons.delete, size: 25),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(width: 1, color: textColorSecondary),
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
                                      reviewCartProvider.updateReviewCartData(
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
                                    reviewCartProvider.updateReviewCartData(
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
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: textColorSecondary),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 17, color: primaryColor),
                            const SizedBox(width: 5),
                            Text(
                              'ADD',
                              style: GoogleFonts.manrope(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
        if (widget.isBool) Divider(height: 1, color: Colors.grey[500]),
      ],
    );
  }
}
