import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/firebase_options.dart';
import 'package:fresh_veggies/providers/product_provider.dart';
import 'package:fresh_veggies/providers/review_cart_provider.dart';
import 'package:fresh_veggies/providers/user_provider.dart';
import 'package:fresh_veggies/screens/home/home_screen.dart';
import 'package:fresh_veggies/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Fresh Veggies',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          primaryColor: primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
