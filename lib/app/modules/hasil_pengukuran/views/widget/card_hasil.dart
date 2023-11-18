import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class CardHasil extends StatelessWidget {
  final String title;
  // final String satuan;
  final String value;
  final bool isLoading;
  final String? valueDitampilkan;

  const CardHasil({
    super.key,
    required this.title,
    required this.value,
    required this.isLoading,
    this.valueDitampilkan,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    color: AppColors.secondaryColor),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Builder(builder: (context) {
                if (isLoading == true &&
                    double.parse(valueDitampilkan.toString()) == 0.0) {
                  return Center(
                    child: LoadingAnimationWidget.discreteCircle(
                        color: AppColors.blue,
                        secondRingColor: AppColors.lightBlue.withOpacity(0.5),
                        thirdRingColor: AppColors.lightGrey3,
                        size: 40),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLoading == true && valueDitampilkan != null
                          ? "$valueDitampilkan "
                          : "$value ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 40.0,
                          color: AppColors.primaryColor),
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
