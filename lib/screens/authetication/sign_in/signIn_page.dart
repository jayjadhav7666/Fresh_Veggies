import 'package:flutter/material.dart';
import 'package:fresh_veggies/auth/email/email_login.dart';
import 'package:fresh_veggies/auth/google/google_auth.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/data/api_exception.dart';
import 'package:fresh_veggies/screens/authetication/forgot_password/forgot_pass_view.dart';
import 'package:fresh_veggies/screens/authetication/sign_up/sign_up.dart';
import 'package:fresh_veggies/screens/authetication/widgets/custom_button.dart';
import 'package:fresh_veggies/screens/authetication/widgets/custom_loginbutton.dart';
import 'package:fresh_veggies/screens/authetication/widgets/custom_textfeild.dart';
import 'package:fresh_veggies/screens/home/home_screen.dart';
import 'package:fresh_veggies/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  void _signIn() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      Utils.snackBar('Please fill all details.', context);
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await _authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      if (mounted) {
        Utils.snackBar(e.toString(), context);
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
                    const SizedBox(height: 30),
                    Text(
                      'Welcome back',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 40,
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

                    CustomLoginButton(
                        image: 'assets/icons/google_logo.png',
                        text: 'Login with Google',
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await GoogleAuthentication()
                              .signWithGoogle(context)
                              .then(
                            (value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomeScreen(),
                                ),
                              );
                              setState(() {
                                isLoading = false;
                              });
                            },
                          ).onError(
                            (error, stackTrace) {
                              setState(() {
                                isLoading = false;
                              });
                              throw FetchDataException(error.toString());
                            },
                          );
                        }),
                    const SizedBox(height: 15),

                    CustomLoginButton(
                      image: 'assets/icons/facebook.png',
                      text: 'Login with Facebook',
                      onTap: () {},
                    ),

                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey)),
                        const SizedBox(width: 7),
                        Text("OR",
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: Colors.black54)),
                        const SizedBox(width: 7),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 25),

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
                    const SizedBox(height: 15),

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
                    //forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ForgotPassView(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: borderColor),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Sign In Button
                    CustomButton(text: 'Sign In', onTap: _signIn),

                    const SizedBox(height: 60),

                    // Register Navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.manrope(
                              fontSize: 17, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpScreen()));
                          },
                          child: Text(
                            "Register",
                            style: GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: borderColor),
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
