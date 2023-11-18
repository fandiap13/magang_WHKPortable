import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wish/app/modules/devices/views/device_view.dart';
import 'package:wish/app/modules/home/views/widget/home_page.dart';
import 'package:wish/app/modules/profile/views/profile_view.dart';
import 'package:wish/app/modules/riwayat_kesehatan/views/riwayat_kesehatan_view.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/services/login_services.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());
  final loginService = LoginService();

  @override
  void initState() {
    super.initState();
    loginService.isLoggedOut();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> page = const [
      HomePage(),
      DeviceView(),
      RiwayatKesehatanView(),
      ProfileView(),
    ];

    return Obx(() => Scaffold(
          body: page.elementAt(controller.selectedIndex.value),
          bottomNavigationBar: Container(
            color: AppColors.lightDark,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: GNav(
                backgroundColor: AppColors.lightDark,
                color: Colors.white,
                rippleColor:
                    Colors.grey, // tab button ripple color when pressed
                hoverColor: Colors.grey, // tab button hover color
                haptic: true, // haptic feedback
                // tabBorderRadius: 15,
                gap: 8,
                curve: Curves.easeOutExpo,
                duration: const Duration(milliseconds: 900),
                iconSize: 24,
                activeColor: Colors.white,
                tabBackgroundColor: AppColors.grey2,
                padding: const EdgeInsets.all(16.0),
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.stethoscope,
                    text: 'Cek kesehatan',
                  ),
                  GButton(
                    icon: LineIcons.medicalNotes,
                    text: 'Riwayat',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: controller.selectedIndex.value,
                onTabChange: (int value) {
                  controller.selectedIndex.value = value;
                },
              ),
            ),
          ),
        ));
  }
}
