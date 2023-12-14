import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:wish/app/services/login_services.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final splashScreenVM = Get.put(SplashScreenController());
  final loginService = LoginService();

  @override
  void initState() {
    super.initState();
    loginService.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                      // color: Colors.red,
                      width: size.width * 0.8,
                      height: size.width * 0.8,
                      child:
                          Image.asset("assets/images/icon_WHK_Portable.png")),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: AppColors.secondaryColor),
                    ),
                    Wrap(
                      children: [
                        Text(
                          "Di ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                              color: AppColors.secondaryColor),
                        ),
                        Text(
                          "WHK Portable",
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "WHK Portable adalah teman kesehatan Anda yang penuh dengan inovasi. Pantau dan tingkatkan kesehatan Anda dengan teknologi yang cerdas. ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                      color: AppColors.secondaryColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.offNamed(Routes.LOGIN);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 2.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    label: const Text(
                      "Ketuk Untuk Mulai",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.0),
                    ),
                    // icon: const Icon(Icons.arrow_forward_rounded),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
