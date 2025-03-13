import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/providers/product_provider.dart';
import 'package:fresh_veggies/providers/user_provider.dart';
import 'package:fresh_veggies/screens/home/drawer_side.dart';
import 'package:fresh_veggies/screens/home/single_product.dart';
import 'package:fresh_veggies/screens/product_overview/product_overview.dart';
import 'package:fresh_veggies/screens/review_cart/review_cart.dart';
import 'package:fresh_veggies/screens/search/search_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  int _currentIndex = 0;
  final CarouselSliderController carouselController =
      CarouselSliderController();
  Widget _buildHerbsProduct(context, productProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Herbs Seasonings',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                          search: productProvider.getherbsProductsDataList),
                    ),
                  );
                },
                child: Text(
                  'View all',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColorSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Row(
              children: productProvider.getherbsProductsDataList
                  .map<Widget>((herbsProduct) {
                return SingleProduct(
                  productId: herbsProduct.productId,
                  productImage: herbsProduct.productImage,
                  productName: herbsProduct.productName,
                  productPrice: herbsProduct.productPrice,
                  productUnit: herbsProduct,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductOverview(
                          productModel: herbsProduct,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFreshFProduct(productProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fresh Fruits',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                          search: productProvider.getfruitsProductsDataList),
                    ),
                  );
                },
                child: Text(
                  'View all',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColorSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: productProvider.getfruitsProductsDataList
                  .map<Widget>((fruitsProduct) {
                return SingleProduct(
                  productId: fruitsProduct.productId,
                  productImage: fruitsProduct.productImage,
                  productName: fruitsProduct.productName,
                  productPrice: fruitsProduct.productPrice,
                  productUnit: fruitsProduct,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductOverview(
                          productModel: fruitsProduct,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRootProduct(productProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Root Vegetable',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                        search:
                            productProvider.getRootVegetablesProductsDataList,
                      ),
                    ),
                  );
                },
                child: Text(
                  'View all',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColorSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: productProvider.getRootVegetablesProductsDataList
                  .map<Widget>((rootProduct) {
                return SingleProduct(
                  productId: rootProduct.productId,
                  productImage: rootProduct.productImage,
                  productName: rootProduct.productName,
                  productPrice: rootProduct.productPrice,
                  productUnit: rootProduct,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductOverview(
                          productModel: rootProduct,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchData();
  }

  List<String> images = [
    'assets/images/banner/banner1.png',
    'assets/images/banner/banner2.jpeg',
    'assets/images/banner/banner3.jpeg',
  ];

  void fetchUserData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.getUserData();
    setState(() {});
  }

  void fetchData() async {
    isLoading = true;
    ProductProvider initProductProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await initProductProvider.fetchHerbsProduct();
    await initProductProvider.fetchrootvegetablesProduct();
    await initProductProvider.fetchFreshFruitsProduct();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      //drawer
      drawer: DrawerSide(),
      backgroundColor: scaffoldBackgroundColor,
      //appbar
      appBar: __buildAppBar(productProvider),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    CarouselSlider(
                      items: images.map((imagePath) {
                        return Builder(builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: 170,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(
                                    imagePath,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: Color.fromRGBO(239, 239, 244, 1),
                                ),
                              ),
                            ),
                          );
                        });
                      }).toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        height: 170,

                        enableInfiniteScroll: false,
                        autoPlayInterval: Duration(
                          seconds: 3,
                        ),
                        // reverse: true,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: images.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () {
                            carouselController.animateToPage(entry.key);
                            setState(() {
                              _currentIndex = entry.key;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            width: _currentIndex == entry.key ? 18 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _currentIndex == entry.key
                                  ? primaryColor
                                  : const Color.fromARGB(255, 211, 205, 205),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    _buildHerbsProduct(context, productProvider),
                    _buildFreshFProduct(productProvider),
                    _buildRootProduct(productProvider),
                  ],
                ),
              ),
            ),
    );
  }

  AppBar __buildAppBar(productProvider) {
    return AppBar(
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(
        color: secondaryColor,
      ),
      elevation: 3,
      shadowColor: Colors.black,
      title: Text(
        'Home',
        style: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textWhiteColor,
        ),
      ),
      actions: [
        CircleAvatar(
          radius: 17,
          backgroundColor: scaffoldBackgroundColor,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    search: productProvider.getSearchList,
                  ),
                ),
              );
            },
            tooltip: 'Search',
            icon: Icon(
              Icons.search,
              color: textColor,
              size: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
          ),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: scaffoldBackgroundColor,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ReviewCart(),
                  ),
                );
              },
              tooltip: 'Shop',
              icon: Icon(
                Icons.shop,
                color: textColor,
                size: 19,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
