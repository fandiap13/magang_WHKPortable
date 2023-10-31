import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/services/login_services.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? automaticallyImplyLeading;
  final bool? logoutButton;

  const AppBarComponent(
      {super.key,
      required this.title,
      this.automaticallyImplyLeading,
      this.logoutButton});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.lightDark,
        statusBarIconBrightness: Brightness.light,
      ),
      actions: [
        if (logoutButton == true)
          IconButton(
              onPressed: () async {
                final loginService = LoginService();
                await loginService.signOut(context);
              },
              icon: const Icon(Icons.logout))
      ],
      title: Text(title),
      centerTitle: true,
      backgroundColor: AppColors.lightDark,
      foregroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading:
          automaticallyImplyLeading == null ? true : false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
