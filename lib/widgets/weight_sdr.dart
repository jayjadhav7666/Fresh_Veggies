import 'package:flutter/material.dart';
import 'package:fresh_veggies/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class WeightDropdown extends StatefulWidget {
  const WeightDropdown({super.key});

  @override
  State createState() => _WeightDropdownState();
}

class _WeightDropdownState extends State<WeightDropdown> {
  final List<String> weightOptions = [
    "50 Gram",
    "100 Gram",
    "150 Gram",
    "500 Gram"
  ];
  String selectedWeight = "50 Gram";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: textColorSecondary),
        borderRadius: BorderRadius.circular(20),
      ),
      child: PopupMenuButton<String>(
        padding: const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
        onSelected: (value) {
          setState(() {
            selectedWeight = value;
          });
        },
        itemBuilder: (context) {
          return weightOptions.map((String weight) {
            return PopupMenuItem<String>(
              value: weight,
              child: Text(
                weight,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textColorSecondary,
                ),
              ),
            );
          }).toList();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedWeight,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textColorSecondary,
              ),
            ),
            const SizedBox(width: 5),
            Icon(Icons.arrow_drop_down, size: 17, color: primaryColor),
          ],
        ),
      ),
    );
  }
}
