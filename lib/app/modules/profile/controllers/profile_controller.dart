// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';

import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wish/app/data/app_base_url.dart';
import 'package:wish/app/models/user_model.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:wish/app/services/secure_storage_service.dart';

class ProfileController extends GetxController {
  final secureStorageService = SecureStorageService();
  final dio = Dio();
  final Map errors = {}.obs;

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
  final tinggiFocusedNode = FocusNode().obs;
  final tanggalLahirFocusedNode = FocusNode().obs;

  final RxBool isLoading = true.obs;

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

  Future<void> getUserProfil() async {
    try {
      isLoading.value = true;

      var token = await secureStorageService.getToken();
      Map<String, dynamic> user = AppUtils.convertJsonFormat(
          jsonDecode(jsonEncode(await secureStorageService.getDataUser())));

      // print(token);
      String userID = user['userId'];

      var response = await dio.get("${AppBaseUrl.url}/users/$userID",
          options: Options(headers: {"Authorization": token.toString()}));
      // var cekJson = UserModel.fromJson(response.data['data']);

      // debugPrint(cekJson.email);
      // debugPrint(cekJson.name);

      // return;
      String? tanggalLahir = DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(response.data['data']['birthday']))
          .toString();

      emailController.value.text = response.data['data']['email'] ?? "";
      nameController.value.text = response.data['data']['name'] ?? "";
      telpController.value.text = response.data['data']['phone'] ?? "";
      genderController.value = StringUtils.capitalize(
                  response.data['data']['gender'].toLowerCase()) ==
              ""
          ? "Laki-laki"
          : StringUtils.capitalize(
              response.data['data']['gender'].toLowerCase());
      tanggalLahirController.value.text = tanggalLahir;
      tinggiController.value.text = "170";

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          AppUtils.toast(
              e.response!.statusMessage.toString(), AppColors.dangerColor);
          // hapus token lalu logout
          await secureStorageService.deleteToken();
          Get.offAndToNamed(Routes.LOGIN);
        } else if (e.type == DioExceptionType.connectionError) {
          AppUtils.toast("Tidak ada koneksi internet !", AppColors.dangerColor);
        } else if (e.type == DioExceptionType.badCertificate) {
          AppUtils.toast(
              "Terdapat kesalahan pengambilan data !", AppColors.dangerColor);
        } else {
          AppUtils.toast(
              "Terdapat kesalahan pada sistem !", AppColors.dangerColor);
        }
      } else {
        debugPrint(e.toString());
        AppUtils.toast(
            "Terdapat kesalahan pada sistem !", AppColors.dangerColor);
      }
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    try {
      isLoading.value = true;

      var token = await secureStorageService.getToken();
      Map<String, dynamic> user = AppUtils.convertJsonFormat(
          jsonDecode(jsonEncode(await secureStorageService.getDataUser())));
      String userID = user['userId'];

      await Dio().put(
        "${AppBaseUrl.url}/users/$userID",
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
            "Authorization": token.toString(),
          },
        ),
      );

      AppUtils.toast("Ubah profil berhasil !", AppColors.primaryColor);

      errors.clear();
      passwordController.value.text = "";

      isLoading.value = false;
      Get.toNamed(Routes.HOME);
    } catch (e) {
      isLoading.value = false;
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          AppUtils.toast(
              e.response!.statusMessage.toString(), AppColors.dangerColor);
          // hapus token lalu logout
          await secureStorageService.deleteToken();
          Get.offAndToNamed(Routes.LOGIN);
        } else if (e.type == DioExceptionType.connectionError) {
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
            // print(field);
          });

          AppUtils.alertDialog(
              context, "Update Profil", e.response!.data['message'].toString());
        } else if (e.type == DioExceptionType.badCertificate) {
          AppUtils.alertDialog(
              context, "Update Profil", e.response!.data['message'].toString());
        }
      } else {
        debugPrint(e.toString());
      }
    }
  }
}
