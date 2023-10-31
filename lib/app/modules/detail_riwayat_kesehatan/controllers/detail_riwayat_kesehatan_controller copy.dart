// import 'package:dio/dio.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:get/get.dart';
// import 'package:wish/app/data/app_base_url.dart';
// import 'package:wish/app/resources/colors/app_colors.dart';
// import 'package:wish/app/resources/utils/app_utils.dart';
// import 'package:flutter/material.dart';

// class DetailRiwayatKesehatanController extends GetxController {
//   // ngawur moment biarin
//   final dataRiwayatKesehatan1 = [].obs;
//   final dataRiwayatKesehatan2 = [].obs;
//   final RxList<FlSpot> dataKesehatan1 = <FlSpot>[].obs;
//   final RxList<FlSpot> dataKesehatan2 = <FlSpot>[].obs;
//   final RxList<String> tanggal = <String>[].obs;

//   final RxSet<String> fieldTable = <String>{}.obs;
//   final RxList<Map<String, dynamic>> detailRiwayatKesehatan =
//       <Map<String, dynamic>>[].obs;

//   final RxBool isLoading = true.obs;

//   // pagination
//   final RxInt totalPage = 0.obs;
//   final RxInt totalItems = 0.obs;
//   final RxInt currentPage = 1.obs;
//   final RxInt limit = 5.obs;
//   final RxString nextPage = "".obs;
//   final RxString previousPage = "".obs;

//   Future<void> getDataRiwayatKesehatan(String url, List type) async {
//     try {
//       // PENANGKAPAN DATA =================================================================
//       // clear data
//       isLoading.value = true;
//       tanggal.clear();
//       dataKesehatan1.clear();
//       dataKesehatan2.clear();
//       dataRiwayatKesehatan1.clear();
//       dataRiwayatKesehatan2.clear();
//       nextPage.value = "";
//       previousPage.value = "";

//       // jika didalam url page dan limit tidak kosong
//       Uri uri = Uri.parse(url);
//       if (uri.queryParameters['page'] != null &&
//           uri.queryParameters['limit'] != null) {
//         currentPage.value = int.parse(uri.queryParameters['page'].toString());
//         limit.value = int.parse(uri.queryParameters['limit'].toString());
//       }

//       // url yang diterima dari parameter
//       late String newUrl;
//       if (nextPage.value == "" && previousPage.value == "") {
//         newUrl = "$url?page=${currentPage.value}&limit=${limit.value}";
//       } else {
//         newUrl = url;
//       }

//       debugPrint("Url anda saat ini: $newUrl");

//       var response = await Dio().get("${AppBaseUrl.url}$newUrl");

//       totalPage.value = response.data['totalPages'];
//       totalItems.value = response.data['totalItems'];

//       // membuat link pagination
//       // jika masih di page 1
//       if (currentPage.value == 1) {
//         nextPage.value =
//             "$url?page=${currentPage.value + 1}&limit=${limit.value}";
//         previousPage.value = "";
//         // next page tidak ada
//       } else if (response.data['nextPage'] == null) {
//         nextPage.value = "";
//         previousPage.value =
//             "$url?page=${currentPage.value - 1}&limit=${limit.value}";
//       } else {
//         nextPage.value =
//             "$url?page=${currentPage.value + 1}&limit=${limit.value}";
//         previousPage.value =
//             "$url?page=${currentPage.value - 1}&limit=${limit.value}";
//       }
//       // END PENANGKAPAN DATA =================================================================

//       // PENGELOLAAN DATA =================================================================
//       // jika data berisi kombinasi
//       if (response.data['combined_data'] != null) {
//         dataRiwayatKesehatan1.value = response.data['combined_data'][type[0]];
//         dataRiwayatKesehatan2.value = response.data['combined_data'][type[1]];
//       } else {
//         dataRiwayatKesehatan1.value = response.data[type[0]];
//       }

//       // ambil salah satu sample
//       // cek apakah datanya pecahan atau tidak
//       if (dataRiwayatKesehatan1[0]['value'].split('/').length > 1) {
//         dataRiwayatKesehatan1.asMap().forEach((index, element) {
//           double i = index.toDouble();
//           String date = element['start_at'] as String;
//           tanggal.add(date);

//           // khusus yang tensimeter / tekanan darah
//           double value1 = double.parse(element['value'].split('/')[0]);
//           double value2 = double.parse(element['value'].split('/')[1]);
//           dataKesehatan1.add(FlSpot(i, value1));
//           dataKesehatan2.add(FlSpot(i, value2));
//         });
//       } else {
//         if (dataRiwayatKesehatan1.isNotEmpty) {
//           dataRiwayatKesehatan1.asMap().forEach((index, element) {
//             double i = index.toDouble();
//             String date = element['start_at'] as String;
//             tanggal.add(date);

//             double value = double.parse(element['value'].toString());
//             dataKesehatan1.add(FlSpot(i, value));
//           });
//         }
//         if (dataRiwayatKesehatan2.isNotEmpty) {
//           dataRiwayatKesehatan2.asMap().forEach((index, element) {
//             double i = index.toDouble();

//             if (dataRiwayatKesehatan2.isNotEmpty) {
//               double value = double.parse(element['value'].toString());
//               dataKesehatan2.add(FlSpot(i, value));
//             }
//           });
//         }
//       }

//       // print(dataRiwayatKesehatan1);
//       // print(dataRiwayatKesehatan2);

//       isLoading.value = false;
//     } catch (e) {
//       isLoading.value = false;
//       if (e is DioException) {
//         if (e.type == DioExceptionType.connectionError) {
//           AppUtils.toast("Tidak ada koneksi internet !", AppColors.dangerColor);
//         } else if (e.type == DioExceptionType.badCertificate) {
//           AppUtils.toast(
//               "Terdapat kesalahan pengambilan data !", AppColors.dangerColor);
//         }
//       } else {
//         debugPrint(e.toString());
//         AppUtils.toast(
//             "Terdapat kesalahan pada sistem !", AppColors.dangerColor);
//       }
//     }
//   }
// }
