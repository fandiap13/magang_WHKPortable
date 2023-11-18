import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class InternetExceptionComponent extends StatelessWidget {
  const InternetExceptionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tidak Ada Koneksi Internet",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: AppColors.secondaryColor),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const SizedBox(
                width: 220,
                child: Text(
                  "Tidak Ada Koneksi Internet Silahkan Coba Lagi.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: AppColors.grey),
                )),
            const SizedBox(
              height: 15.0,
            ),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.primaryColor),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10))),
                  child: const Text(
                    "Coba Lagi",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
