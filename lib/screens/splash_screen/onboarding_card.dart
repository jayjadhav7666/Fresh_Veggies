import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingCard extends StatelessWidget {
  final String image;
  final String title;
  final String info;

  const OnboardingCard({
    super.key,
    required this.image,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Image.asset(
            'assets/icons/whitelogo.png',
            height: 200,
            width: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 36, // Reduced for better fit
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              info,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 18, // Adjusted size
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(child: SizedBox()), // Responsive Spacer
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'By joining you agree to our Terms of Service and Privacy Policy',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: Color.fromRGBO(200, 199, 204, 1),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
