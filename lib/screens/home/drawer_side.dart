import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/providers/user_provider.dart';
import 'package:fresh_veggies/screens/home/home_screen.dart';
import 'package:fresh_veggies/screens/my_profile/my_profile.dart';
import 'package:fresh_veggies/screens/review_cart/review_cart.dart';
import 'package:fresh_veggies/screens/wishList.dart/wishlist_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerSide extends StatefulWidget {
  final UserProvider userProvider;
  const DrawerSide({super.key, required this.userProvider});

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  int selectedIndex = 0; // Track selected item

  Widget listTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required int index,
  }) {
    return Material(
      color: selectedIndex == index ? Colors.grey[300] : Colors.transparent,
      child: ListTile(
        onTap: () {
          setState(() {
            selectedIndex = index; // Update selected index
          });
          onTap();
        },
        leading: Icon(
          icon,
          size: 26,
          color: textColor,
        ),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.getUserInfo;
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          Container(
            width: double.infinity,
            color:
                Colors.green[500], // Ensure the color is green above the header
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[500], // Set DrawerHeader background color
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 43,
                    backgroundColor: scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: scaffoldBackgroundColor,
                      backgroundImage: NetworkImage(
                        userData.userImage ??
                            "https://www.pngfind.com/pngs/m/467-4675403_png-file-blank-person-transparent-png.png",
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 165,
                        child: Text(
                          userData.userName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            color: secondaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 165,
                        child: Text(
                          userData.userEmail,
                          style: GoogleFonts.manrope(
                            color: secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // List of Items
          Expanded(
            child: Container(
              color: secondaryColor, // Set drawer items background color
              child: Column(
                children: [
                  listTile(
                    icon: Icons.home_outlined,
                    title: 'Home',
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    index: 0,
                  ),
                  listTile(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Review Cart',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ReviewCart()),
                      );
                    },
                    index: 1,
                  ),
                  listTile(
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyProfile(
                            userProvider: widget.userProvider,
                          ),
                        ),
                      );
                    },
                    index: 2,
                  ),
                  listTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notification',
                    onTap: () {},
                    index: 3,
                  ),
                  listTile(
                    icon: Icons.star_outline,
                    title: 'Rating & Review',
                    onTap: () {},
                    index: 4,
                  ),
                  listTile(
                    icon: Icons.favorite_outline,
                    title: 'Wishlist',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const WishListScreen(),
                        ),
                      );
                    },
                    index: 5,
                  ),
                  listTile(
                    icon: Icons.copy_outlined,
                    title: 'Raise a Complaint',
                    onTap: () {},
                    index: 6,
                  ),
                  listTile(
                    icon: Icons.format_quote_outlined,
                    title: 'FAQs',
                    onTap: () {},
                    index: 7,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Support",
                          style: GoogleFonts.manrope(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "Call us :",
                              style: GoogleFonts.manrope(
                                color: textColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "+917666210348",
                              style: GoogleFonts.manrope(
                                color: textColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              "Mail us :",
                              style: GoogleFonts.manrope(
                                color: textColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "jp7028@gmail.com",
                                style: GoogleFonts.manrope(
                                  color: textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
