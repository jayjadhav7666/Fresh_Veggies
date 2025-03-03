import 'package:flutter/material.dart';
import 'package:fresh_veggies/auth/google/google_auth.dart';

import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/screens/home/drawer_side.dart';
import 'package:fresh_veggies/screens/authetication/sign_in/signIn_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Widget listTile(IconData iconData, String title, VoidCallback onTap) {
    return Column(
      children: [
        Divider(
          height: 1,
          color: Colors.grey[500],
        ),
        ListTile(
          leading: Icon(
            iconData,
            size: 25,
            color: textColor,
          ),
          title: Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: textColor,
          ),
          onTap: onTap,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      //drawer
      drawer: DrawerSide(),
      //appbar
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 80,
                              width: 250,
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Billu Gadekar",
                                        style: GoogleFonts.manrope(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "billu@gmail.com",
                                        style: GoogleFonts.manrope(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 1,
                                          color: primaryColor,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.edit,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      listTile(Icons.shopping_bag_outlined, 'My Orders', () {}),
                      listTile(Icons.location_on_outlined,
                          'My Delivery Address', () {}),
                      listTile(Icons.share, 'Refer A Friends', () {}),
                      listTile(Icons.description_outlined, 'Terms & Condition',
                          () {}),
                      listTile(Icons.security, 'Privay Policy', () {}),
                      listTile(Icons.business, 'About Us', () {}),
                      listTile(
                        Icons.logout_outlined,
                        'Log Out',
                        () async {
                          await GoogleAuthentication().googleSignOut().then(
                            (value) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => SignIn(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 60,
            left: 25,
            child: CircleAvatar(
              radius: 45,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  "https://newprofilepic.photo-cdn.net//assets/images/article/profile.jpg?90af0c8",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: secondaryColor,
      ),
      title: Text(
        'My Profile',
        style: GoogleFonts.manrope(
          fontWeight: FontWeight.w700,
          color: secondaryColor,
        ),
      ),
    );
  }
}
