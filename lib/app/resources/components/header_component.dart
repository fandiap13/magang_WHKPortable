import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wish/app/modules/home/controllers/home_controller.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/services/login_services.dart';

class HeaderComponent extends StatefulWidget {
  final String name;
  final String imgUrl;

  const HeaderComponent({
    super.key,
    this.name = "Unknown",
    this.imgUrl = "https://source.unsplash.com/user/wsanter",
  });

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  String? _selectedItem;
  final homeViewVM = Get.put(HomeController());
  final loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
          right: 15.0, left: 15.0, top: 30.0, bottom: 40.0),
      decoration: const BoxDecoration(
        color: AppColors.lightDark,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(160, 20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat datang,",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                    color: Colors.white),
              ),
              Text(
                widget.name,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    color: Colors.white),
              )
            ],
          ),
          PopupMenuButton(
            onSelected: (value) async {
              setState(() {
                _selectedItem = value;
              });
              if (value == "profile") {
                homeViewVM.selectedIndex.value = 3;
              }
              if (value == "logout") {
                await loginService.signOut(context);
              }
            },
            // child: CircleAvatar(
            //   radius: 30,
            //   backgroundImage: NetworkImage(widget.imgUrl),
            // ),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const Icon(
                Icons.person,
                color: AppColors.lightDark,
                size: 35.0,
              ),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                  value: "profile",
                  child: Row(
                    children: [
                      const Icon(LineIcons.user),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Profile",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: AppColors.secondaryColor),
                      ),
                    ],
                  )),
              PopupMenuItem(
                value: "logout",
                child: Row(
                  children: [
                    const Icon(LineIcons.alternateSignOut),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
