// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wish/app/data/app_base_url.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:wish/app/services/secure_storage_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusedNode = FocusNode().obs;
  final passwordFocusedNode = FocusNode().obs;

  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.close();
    passwordController.close();
    super.onClose();
  }

  void clearField() {
    emailController.value.clear();
    passwordController.value.clear();
  }

  Future<void> login(BuildContext context) async {
    try {
      isLoading.value = true;

      var response = await Dio().post(
        "${AppBaseUrl.url}/auth/login",
        data: {
          "email": emailController.value.text.trim(),
          "password": passwordController.value.text.trim(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      final secureStorageService = SecureStorageService();
      await secureStorageService.setToken(response.data['token'].toString());

      AppUtils.toast(
          response.data['Message'].toString(), AppColors.primaryColor);

      isLoading.value = false;
      clearField();

      Get.offAndToNamed(Routes.HOME);
    } catch (e) {
      isLoading.value = false;
      // clearField();
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          AppUtils.alertDialog(
              context, "Login Gagal", e.response!.data['error'].toString());
        }
        // print(e.response!.statusCode);
        // print(e.response!.data.toString());
        // debugPrint(e.response!.statusCode.toString());
        // debugPrint(e.response!.data['message'].toString());
        else if (e.type == DioExceptionType.connectionError) {
          AppUtils.toast("Tidak ada koneksi internet !", AppColors.dangerColor);
        } else if (e.type == DioExceptionType.badResponse) {
          AppUtils.alertDialog(
              context, "Login Gagal", e.response!.data['message']);
        } else if (e.type == DioExceptionType.badCertificate) {
          AppUtils.alertDialog(
              context, "Login Gagal", e.response!.data['message']);
        }
      } else {
        debugPrint(e.toString());
        AppUtils.alertDialog(context, "Error !", e.toString());
      }
    }
  }
}
