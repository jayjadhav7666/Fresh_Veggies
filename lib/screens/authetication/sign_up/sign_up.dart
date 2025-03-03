import 'package:flutter/material.dart';
import 'package:fresh_veggies/auth/email/email_login.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/screens/authetication/sign_in/signIn_page.dart';
import 'package:fresh_veggies/screens/authetication/widgets/custom_button.dart';
import 'package:fresh_veggies/screens/authetication/widgets/custom_textfeild.dart';
import 'package:fresh_veggies/screens/home/home_screen.dart';
import 'package:fresh_veggies/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  final AuthService _authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    nameFocusNode.dispose();
    passwordFocusNode.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      Utils.snackBar('Please fill all details.', context);
      return;
    }
    if (_passwordController.text.trim().isNotEmpty &&
        _passwordController.text.trim().length < 6) {
      Utils.snackBar('Please enter minimum 6 digit password.', context);
      return;
    }

    setState(() {
      isLoading = true;
    });
    try {
      await _authService.signUpWithEmail(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        context,
      );
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      if (mounted) {
        Utils.snackBar(
          e.toString(),
          context,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/freshveggies.png',
                      height: 200,
                      width: 200,
                    ),

                    Text(
                      'Create New Account',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Log in to your account using social networks",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Name Field
                    CustomTextField(
                      controller: _nameController,
                      focusNode: nameFocusNode,
                      hintText: 'Name',
                      onFieldSubmitted: (value) {
                        Utils.fieldFocusChange(
                            context, nameFocusNode, emailFocusNode);
                      },
                    ),
                    const SizedBox(height: 18),
                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      focusNode: emailFocusNode,
                      hintText: 'Email',
                      onFieldSubmitted: (value) {
                        Utils.fieldFocusChange(
                            context, emailFocusNode, passwordFocusNode);
                      },
                    ),
                    const SizedBox(height: 18),

                    // Password Field with Visibility Toggle
                    ValueListenableBuilder(
                      valueListenable: _obscurePassword,
                      builder: (context, value, child) {
                        return CustomTextField(
                          controller: _passwordController,
                          focusNode: passwordFocusNode,
                          hintText: 'Password',
                          obscureText: _obscurePassword.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              size: 24,
                            ),
                            onPressed: () {
                              _obscurePassword.value = !_obscurePassword.value;
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // Sign In Button
                    CustomButton(text: 'SignUp', onTap: _signUp),

                    const SizedBox(height: 60),

                    // Register Navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.manrope(
                              fontSize: 17, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignIn(),
                              ),
                            );
                          },
                          child: Text(
                            "Log in",
                            style: GoogleFonts.manrope(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: borderColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
