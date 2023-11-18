import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish/app/data/app_base_url.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:wish/app/services/secure_storage_service.dart';

class HomeController extends GetxController {
  final secureStorageService = SecureStorageService();

  RxString name = "".obs;

  RxInt selectedIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxBool statusData = false.obs; // false artinya data kosong
  RxString userID = "".obs;

  Map bloodPressure = {}.obs;
  Map bloodOxygen = {}.obs;
  Map heartRate = {}.obs;
  Map bodyMassIndex = {}.obs;
  Map bodyWeight = {}.obs;
  Map bodyTemperature = {}.obs;

  Future<void> getName() async {
    var token = await secureStorageService.getToken();
    Map<String, dynamic> user = AppUtils.convertJsonFormat(
        jsonDecode(jsonEncode(await secureStorageService.getDataUser())));

    String userID = user['userId'];

    var response = await Dio().get("${AppBaseUrl.url}/users/$userID",
        options: Options(headers: {"Authorization": token.toString()}));

    name.value = response.data['data']['name'] ?? "";
  }

  Future<void> getNewstSensor() async {
    try {
      bloodPressure.clear();
      bloodOxygen.clear();
      heartRate.clear();
      bodyMassIndex.clear();
      bodyWeight.clear();
      bodyTemperature.clear();

      isLoading.value = true;

      var token = await secureStorageService.getToken();
      Map<String, dynamic> user = AppUtils.convertJsonFormat(
          jsonDecode(jsonEncode(await secureStorageService.getDataUser())));
      userID.value = user['userId'];

      var response = await Dio().get(
          "${AppBaseUrl.url}/sensor/latestData/${userID.value}",
          options: Options(headers: {"Authorization": token.toString()}));

      // print(response.data['blood_pressure']);
      if (response.data['blood_oxygen'].length > 0) {
        bloodOxygen = response.data['blood_oxygen'][0];
      }
      if (response.data['heart_rate'].length > 0) {
        heartRate = response.data['heart_rate'][0];
      }
      if (response.data['body_mass_index'].length > 0) {
        bodyMassIndex = response.data['body_mass_index'][0];
      }
      if (response.data['body_weight'].length > 0) {
        bodyWeight = response.data['body_weight'][0];
      }
      if (response.data['blood_pressure'].length > 0) {
        bloodPressure = response.data['blood_pressure'][0];
      }
      if (response.data['body_temperature'].length > 0) {
        bodyTemperature = response.data['body_temperature'][0];
      }

      statusData.value = true;
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
      // isLoading.value = false;

      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          AppUtils.toast(
              e.response!.statusMessage.toString(), AppColors.dangerColor);
          // hapus token lalu logout
          await secureStorageService.deleteToken();
          Get.offAndToNamed(Routes.LOGIN);
        } else if (e.response?.statusCode == 404) {
          statusData.value = false; // false artinya data kosong
          isLoading.value = false;
        } else if (e.type == DioExceptionType.connectionError) {
          AppUtils.toast("Tidak ada koneksi internet !", AppColors.dangerColor);
        } else if (e.type == DioExceptionType.badCertificate) {
          AppUtils.toast(
              "Terdapat kesalahan pengambilan data !", AppColors.dangerColor);
        }
      } else {
        debugPrint(e.toString());
        AppUtils.toast(
            "Terdapat kesalahan pada sistem !", AppColors.dangerColor);
      }
    }
  }
}
