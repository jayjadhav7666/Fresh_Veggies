import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  final ValueChanged<String>? onFieldSubmitted;

  const CustomTextField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 1,
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 1,
            color: borderColor,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
