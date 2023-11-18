import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class HeaderText extends StatelessWidget {
  final String headerText1;
  final String headerText2;

  const HeaderText({
    super.key,
    required this.headerText1,
    required this.headerText2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText1,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 35.0,
              color: AppColors.secondaryColor),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          headerText2,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: AppColors.blue),
        )
      ],
    );
  }
}
