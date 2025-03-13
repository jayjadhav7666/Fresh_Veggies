import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/model/product_model.dart';
import 'package:fresh_veggies/screens/home/home_screen.dart';
import 'package:fresh_veggies/screens/product_overview/product_overview.dart';
import 'package:fresh_veggies/widgets/single_item.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  final List<ProductModel> search;
  const SearchScreen({super.key, required this.search});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  searchItems(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return searchFood;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    query = '';
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> filteredList = searchItems(query);
    log('search');
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: widget.search.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                ListTile(
                  title: Text('Items'),
                ),
                Container(
                  height: 52,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(239, 239, 239, 1),
                      hintText: "Search for items in the store",
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                filteredList.isEmpty && query.isNotEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "No items found",
                            style: GoogleFonts.manrope(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: filteredList.map(
                          (data) {
                            return SingleItem(
                              isBool: false,
                              productImage: data.productImage,
                              productName: data.productName,
                              productPrice: data.productPrice,
                              productId: data.productId,
                              productQuantity: data.productQuantity,
                              productUnit: data.productUnit,
                              onDelete: () {},
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductOverview(
                                      productModel: data,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),
              ],
            ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(
        color: secondaryColor,
      ),
      elevation: 3,
      shadowColor: Colors.black,
      title: Text(
        'Search',
        style: GoogleFonts.manrope(
          fontWeight: FontWeight.w700,
          color: secondaryColor,
        ),
      ),
      leading: BackButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.filter_list,
              size: 25,
              color: secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
