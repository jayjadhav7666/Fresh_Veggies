import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/model/product_model.dart';
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
  Widget build(BuildContext context) {
    List<ProductModel> filteredList = searchItems(query);
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: widget.search.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator if data is empty
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
                        borderRadius: BorderRadius.circular(30),
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
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductOverview(
                                        productId: data.productId,
                                        productName: data.productName,
                                        productImage: data.productImage,
                                        productPrice: data.productPrice,
                                        description: data.description,
                                        productQuantity: data.productQuantity),
                                  ),
                                );
                              },
                              child: SingleItem(
                                isBool: false,
                                productImage: data.productImage,
                                productName: data.productName,
                                productPrice: data.productPrice,
                                productId: data.productId,
                                productQuantity: 1,
                                onDelete: () {},
                              ),
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
