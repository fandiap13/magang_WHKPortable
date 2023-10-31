import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class ButtonComponent extends StatelessWidget {
  final VoidCallback? onPress;
  final Color bgColor;
  final Color textColor;
  final String text;
  final IconData? icon;
  final bool? isLoading;

  const ButtonComponent({
    this.onPress,
    required this.text,
    required this.isLoading,
    this.bgColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
          onPressed: onPress,
          style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(textColor),
              foregroundColor: MaterialStateProperty.all<Color>(textColor),
              backgroundColor: MaterialStateProperty.all<Color>(
                  isLoading == true ? bgColor.withOpacity(0.5) : bgColor),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)))),
          icon: isLoading == false
              ? icon == null
                  ? const Text("")
                  : Icon(
                      icon,
                      size: 25.0,
                    )
              : const Text(""),
          label: Builder(builder: (context) {
            if (isLoading == true) {
              return LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white, size: 25.0);
            }
            return Text(
              text,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 20.0),
            );
          })),
    );
  }
}
