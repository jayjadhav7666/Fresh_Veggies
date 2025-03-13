import 'package:flutter/material.dart';
import 'package:fresh_veggies/screens/splash_screen/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const OnboardingScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/icons/freshveggies.png',
                height: 300,
                width: 400,
              ),
              Expanded(child: Image.asset('assets/images/splashscreen.png')),
            ],
          ),
        ),
      ),
    );
  }
}
