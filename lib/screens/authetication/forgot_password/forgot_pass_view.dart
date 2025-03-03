import 'package:flutter/material.dart';
import 'package:fresh_veggies/auth/email/forgotpass.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:fresh_veggies/screens/authetication/widgets/custom_button.dart';
import 'package:fresh_veggies/screens/authetication/widgets/custom_textfeild.dart';
import 'package:fresh_veggies/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassView extends StatefulWidget {
  const ForgotPassView({super.key});

  @override
  State<ForgotPassView> createState() => _ForgotPassViewState();
}

class _ForgotPassViewState extends State<ForgotPassView> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  Future<void> _sendResetLink() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      Utils.snackBar('Please enter your email', context);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await ForgotPasswordEmail().forgotPassword(email);
      Utils.snackBar('Reset link sent to your email', context);
      Navigator.pop(context);
    } catch (error) {
      Utils.snackBar(error.toString(), context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        title: Text(
          'Forgot  Password',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            fontSize: 19,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        child: Column(
          children: [
            Text(
              'Enter your email and will send you instruction on how to reset it',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
            ),
            const SizedBox(
              height: 30,
            ),
            isLoading
                ? CircularProgressIndicator(
                    color: primaryColor,
                  )
                : CustomButton(
                    text: 'Send',
                    onTap: _sendResetLink,
                  ),
          ],
        ),
      ),
    );
  }
}
