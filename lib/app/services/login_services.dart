// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish/app/data/app_base_url.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:wish/app/services/secure_storage_service.dart';

class LoginService {
  final secureStorageService = SecureStorageService();

  // mengecek apakah token ada ketika sudah login
  Future<void> isLoggedOut() async {
    String? token = await secureStorageService.getToken();
    // print(token.runtimeType);
    // bool statusToken = bool.parse(token.toString());
    // ketika token kosong
    if (token == null) {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

  // mengecek apakah token ada ketika belum login
  Future<void> isLoggedIn() async {
    String? token = await secureStorageService.getToken();
    // ketika token kosong
    if (token != null) {
      Get.offAndToNamed(Routes.HOME);
    }
  }

  Future<void> signOut(BuildContext context) async {
    Future<void> action() async {
      try {
        await Dio().post("${AppBaseUrl.url}/auth/logout");
        await secureStorageService.deleteToken();
      } catch (e) {
        await secureStorageService.deleteToken();
        debugPrint(e.toString());
      }
      Get.offAllNamed(Routes.LOGIN);
    }

    AppUtils.confirmDialog(context, "Logout",
        "Apakah anda yakin ingin logout ?", "Ya", action, false);
  }
}
