import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fresh_veggies/colors.dart';

class CustomLoginButton extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;

  const CustomLoginButton({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Row(
          children: [
            Image.asset(image),
            const SizedBox(width: 15),
            Text(
              text,
              style: GoogleFonts.manrope(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}