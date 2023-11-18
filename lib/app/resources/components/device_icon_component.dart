import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class DeviceIconComponent extends StatelessWidget {
  const DeviceIconComponent({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGrey3,
          ),
          child: Icon(
            icon,
            color: AppColors.grey,
            size: 20.0,
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: AppColors.secondaryColor),
        )
      ],
    );
  }
}
