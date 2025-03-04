import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/auth/google/google_auth.dart';

import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/providers/user_provider.dart';
import 'package:fresh_veggies/screens/home/drawer_side.dart';
import 'package:fresh_veggies/screens/authetication/sign_in/signIn_page.dart';
import 'package:fresh_veggies/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  final UserProvider userProvider;
  const MyProfile({super.key, required this.userProvider});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isLoading = false;
  XFile? selectedImage;
  String? url;

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
              fontSize: 14,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: textColor,
          ),
          onTap: onTap,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.getUserInfo;
    return Scaffold(
      backgroundColor: primaryColor,
      //drawer
      drawer: DrawerSide(
        userProvider: widget.userProvider,
      ),
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
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          userData.userName,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.manrope(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          userData.userEmail,
                                          overflow: TextOverflow.ellipsis,
                                          // maxLines: 1,
                                          style: GoogleFonts.manrope(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showEditBottomSheet(context);
                                    },
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
                  userData.userImage ??
                      "https://www.pngfind.com/pngs/m/467-4675403_png-file-blank-person-transparent-png.png",
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

  void _showEditBottomSheet(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.userProvider.getUserInfo.userName);
    TextEditingController emailController =
        TextEditingController(text: widget.userProvider.getUserInfo.userEmail);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Profile",
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 20),

              // Profile Picture
              GestureDetector(
                onTap: () => _pickImage(),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: selectedImage != null
                          ? FileImage(File(selectedImage!.path))
                          : widget.userProvider.getUserInfo.userImage != null
                              ? NetworkImage(
                                  widget.userProvider.getUserInfo.userImage!)
                              : const NetworkImage(
                                  "https://www.pngfind.com/pngs/m/467-4675403_png-file-blank-person-transparent-png.png"),
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.camera_alt, color: primaryColor, size: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // Name Field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              // Email Field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    widget.userProvider.updateUserData(
                      currentUser: FirebaseAuth.instance.currentUser!,
                      userName: nameController.text.trim(),
                      userEmail: emailController.text.trim(),
                      userImage: url,
                    );

                    // Close the bottom sheet
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Save Changes",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImage() async {
    selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (selectedImage != null) {
      String filePath =
          'profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      _uploadImage(filePath: filePath);
    }
  }

  void _uploadImage({required String filePath}) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child(filePath)
          .putFile(File(selectedImage!.path));

      url =
          await FirebaseStorage.instance.ref().child(filePath).getDownloadURL();
    } catch (e) {
      Utils.snackBar(e.toString(), context);
    }
  }
}
