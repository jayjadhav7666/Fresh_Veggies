import 'package:flutter/material.dart';
import 'package:fresh_veggies/screens/splash_screen/onboarding_card.dart';
import 'package:fresh_veggies/screens/authetication/sign_in/signIn_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingCard> _onboardingCardPage = [
    OnboardingCard(
      image: 'assets/images/onboarding/image1.png',
      title: 'Shop nearby stores',
      info:
          'Find the favorite stores you want by your location or neighborhood',
    ),
    OnboardingCard(
      image: 'assets/images/onboarding/image2.png',
      title: 'Fresh groceries just for you',
      info: 'All items have real freshness and are intended for your needs',
    ),
    OnboardingCard(
      image: 'assets/images/onboarding/image3.png',
      title: 'Deliver or pickup as you want',
      info: 'Choose to be delivery or pickup according to when you want',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _onboardingCardPage.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: _onboardingCardPage,
          ),
          if (_currentPage != 2)
            Positioned(
              top: 30,
              right: 20,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.4,
            bottom: 270,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _onboardingCardPage.length,
              effect: ExpandingDotsEffect(
                dotHeight: 14,
                expansionFactor: 2,
                activeDotColor: const Color.fromRGBO(147, 194, 47, 1),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: InkWell(
                onTap: _nextPage,
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(147, 194, 47, 1),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
