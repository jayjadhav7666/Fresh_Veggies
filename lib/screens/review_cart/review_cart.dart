import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/model/review_cart_model.dart';
import 'package:fresh_veggies/providers/review_cart_provider.dart';
import 'package:fresh_veggies/widgets/single_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatefulWidget {
  const ReviewCart({super.key});

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Column(
          children: [
            Divider(
              height: 1,
              color: Colors.grey[500],
            ),
            ListTile(
              title: Text(
                "Total Amount",
                style: GoogleFonts.manrope(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                '\$190.0',
                style: GoogleFonts.manrope(
                  color: Colors.green[900],
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Container(
                width: 160,
                height: 80,
                margin: const EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: primaryColor,
                  height: 90,
                  child: Center(
                    child: Text(
                      "Checkout",
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: secondaryColor),
        backgroundColor: primaryColor,
        shadowColor: Colors.black,
        elevation: 3,
        title: Text(
          "Review Cart",
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            color: secondaryColor,
          ),
        ),
      ),
      body: Consumer<ReviewCartProvider>(
        builder: (context, reviewCartProvider, child) {
          return ListView.builder(
            itemCount: reviewCartProvider.getreviewCartDataList.length,
            itemBuilder: (context, index) {
              ReviewCartModel data =
                  reviewCartProvider.getreviewCartDataList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SingleItem(
                  isBool: true,
                  productImage: data.cartImage,
                  productName: data.cartName,
                  productPrice: data.cartPrice,
                  productId: data.cartId,
                  productQuantity: data.cartQuantity,
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (contex) {
                        return AlertDialog(
                          backgroundColor: scaffoldBackgroundColor,
                          title: Text(
                            "Remove Item",
                            style: GoogleFonts.manrope(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            "Are you sure you want to remove this item from the cart?",
                            style: GoogleFonts.manrope(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                reviewCartProvider
                                    .deleteReviewData(data.cartId);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Yes',
                                style: GoogleFonts.manrope(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[400]),
                              child: Text(
                                'No',
                                style: GoogleFonts.manrope(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
