import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/providers/wistlist_provider.dart';
import 'package:fresh_veggies/widgets/single_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WishListProvider>(context, listen: false).getWishtListData();
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    wishListProvider.getWishtListData();
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: secondaryColor),
        backgroundColor: primaryColor,
        shadowColor: Colors.black,
        elevation: 3,
        title: Text(
          "WishList",
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            color: secondaryColor,
          ),
        ),
      ),
      body: Consumer<WishListProvider>(
        builder: (context, wishListScreenProvider, child) {
          return ListView.builder(
            itemCount: wishListScreenProvider.getWishList.length,
            itemBuilder: (context, index) {
              final data = wishListScreenProvider.getWishList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SingleItem(
                  isBool: true,
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productId: data.productId,
                  productQuantity: data.productQuantity,
                  cartUnit: data.productUnit[0],
                  isFavourite: true,
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (contex) {
                        return AlertDialog(
                          backgroundColor: scaffoldBackgroundColor,
                          title: Text(
                            "WishList Product",
                            style: GoogleFonts.manrope(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            "Are you sure you want to remove this item from the WishList?",
                            style: GoogleFonts.manrope(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                wishListProvider.delete(data.productId);
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
