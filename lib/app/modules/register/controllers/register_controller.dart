// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wish/app/data/app_base_url.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final telpController = TextEditingController().obs;
  final genderController = "Laki-laki".obs;
  final tinggiController = TextEditingController().obs;
  final tanggalLahirController = TextEditingController().obs;

  final emailFocusedNode = FocusNode().obs;
  final nameFocusedNode = FocusNode().obs;
  final passwordFocusedNode = FocusNode().obs;
  final telpFocusedNode = FocusNode().obs;
  final genderFocusedNode = FocusNode().obs;
  final umurFocusedNode = FocusNode().obs;
  final tinggiFocusedNode = FocusNode().obs;
  final tanggalLahirFocusedNode = FocusNode().obs;

  final RxBool isLoading = false.obs;
  final Map errors = {}.obs;

  @override
  void onClose() {
    emailController.close();
    passwordController.close();
    nameController.close();
    telpController.close();
    genderController.close();
    tinggiController.close();
    tanggalLahirController.close();
    super.onClose();
  }

  void clearField() {
    emailController.value.clear();
    passwordController.value.clear();
    nameController.value.clear();
    telpController.value.clear();
    genderController.value = "Laki-laki";
    tinggiController.value.clear();
    tanggalLahirController.value.clear();
  }

  Future<void> register(BuildContext context) async {
    try {
      errors.clear();
      isLoading.value = true;

      await Dio().post(
        "${AppBaseUrl.url}/auth/register",
        data: {
          "email": emailController.value.text.trim(),
          "password": passwordController.value.text.trim(),
          "name": nameController.value.text.trim(),
          "gender": genderController.value,
          "phone": telpController.value.text.trim(),
          "birthday": tanggalLahirController.value.text.trim(),
          "tinggi": tinggiController.value.text.trim(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      AppUtils.toast("Register berhasil !", AppColors.primaryColor);

      isLoading.value = false;

      clearField();
      Get.toNamed(Routes.LOGIN);
    } catch (e) {
      isLoading.value = false;
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          AppUtils.toast("Tidak ada koneksi internet !", AppColors.dangerColor);
        } else if (e.type == DioExceptionType.badResponse) {
          // Menyimpan data error
          e.response!.data['errors'].forEach((value) {
            String field = value['path'].toString();
            String msg = value['msg'];
            // mengambil field name yang duplikat dari errors
            var sameField = errors.keys.where((key) => key == field);
            if (sameField.isEmpty) {
              errors[field] = "- $msg.";
            } else {
              errors[field] = "${errors[field]}\n- $msg.";
            }
            print(field);
          });

          AppUtils.alertDialog(context, "Registrasi Gagal",
              e.response!.data['message'].toString());
        } else if (e.type == DioExceptionType.badCertificate) {
          AppUtils.alertDialog(context, "Registrasi Gagal",
              e.response!.data['message'].toString());
        }
      } else {
        debugPrint(e.toString());
      }
    }
  }
}
