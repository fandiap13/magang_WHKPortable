// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wish/app/data/app_base_url.dart';
import 'package:wish/app/modules/connect_device/controllers/connect_device_controller.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:wish/app/services/secure_storage_service.dart';
import 'package:wish/app/services/sensor_service.dart';

class DeviceController extends GetxController {
  final connectDeviceVM = Get.put(ConnectDeviceController());
  final sensorService = Get.put(SensorService());
  final secureStorageService = SecureStorageService();
  final RxBool isLoading = false.obs;

  final List<Map> listDevice = [
    {
      "deviceID": "17:71:12:4E:C6:95",
      "characteristicID": "0000ffe4-0000-1000-8000-00805f9b34fb",
      "nama": "Oksimeter",
      "img_url": "assets/images/oksimeter.png",
      "description":
          "Pulse oksimeter adalah alat medis yang digunakan untuk mengukur kadar oksigen dalam darah seseorang dan juga mengukur denyut nadi mereka. Alat ini sering digunakan dengan cara meletakkan probe di ujung jari atau daerah tubuh lainnya. Pulse oksimeter bekerja dengan mengirim cahaya merah dan inframerah melalui jaringan kulit untuk mendeteksi jumlah oksigen yang diikat pada hemoglobin dalam darah. Informasi ini ditampilkan dalam bentuk persentase tingkat oksigen dalam darah (SpO2) dan denyut nadi per menit. Pulse oksimeter sangat berguna dalam pemantauan pasien dengan gangguan pernapasan, seperti penyakit paru-paru atau COVID-19, serta dalam situasi medis lainnya di mana pemantauan tingkat oksigen dalam darah dan detak jantung penting.",
      "hasil_pengukuran": ["Oksigen Darah (%)", "Detak Jantung (detak/menit)"],
    },
    {
      "deviceID": "18:7A:93:AA:DC:CF",
      "characteristicID": "0000fff1-0000-1000-8000-00805f9b34fb",
      "nama": "Berat Badan",
      "img_url": "assets/images/berat_badan.png",
      "description":
          "Timbangan adalah perangkat atau alat yang digunakan untuk mengukur berat tubuh seseorang. Ini adalah alat yang umumnya ditemukan di berbagai lingkungan, termasuk rumah, pusat kebugaran, fasilitas medis, dan banyak tempat lainnya. Timbangan berat badan bekerja dengan prinsip dasar pengukuran gaya gravitasi yang diberikan oleh berat tubuh individu. Hasil pengukuran berat badan ini umumnya disajikan dalam kilogram atau pon, dan digunakan untuk berbagai tujuan, termasuk pemantauan kesehatan, kebugaran, pengendalian berat badan, serta dalam bidang medis untuk diagnosis dan perawatan yang tepat. Beberapa timbangan berat badan modern juga dilengkapi dengan berbagai fitur tambahan seperti pengukuran indeks massa tubuh (BMI), pemantauan lemak tubuh, dan konektivitas dengan perangkat digital untuk pemantauan dan analisis data.",
      "hasil_pengukuran": ["Berat badan (Kg)", "BMI (Kg/M2)"],
    },
    {
      "deviceID": "7C:01:0A:E6:97:B9",
      "characteristicID": "00002a1c-0000-1000-8000-00805f9b34fb",
      "nama": "Termometer",
      "img_url": "assets/images/termometer.png",
      "description":
          "Termometer adalah alat untuk mengukur suhu tubuh manusia. Suhu normal tubuh berkisar antara 36,5°C hingga 37,5°C. Alat ini digunakan untuk memantau kesehatan dan mendeteksi demam. Ada berbagai jenis termometer, termasuk digital, inframerah, dan raksa (jarang digunakan).",
      "hasil_pengukuran": ["Suhu Tubuh (°C)"],
    },
    // {
    //   "deviceID": "17:71:12:4E:C6:95",
    //   "characteristicID": "0000ffe4-0000-1000-8000-00805f9b34fb",
    //   "nama": "Tekanan Darah",
    //   "img_url": "assets/images/tensimeter.png",
    //   "description":
    //       "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Eveniet tempora consequatur similique. Voluptates explicabo reiciendis fuga laborum velit natus minima eligendi voluptas minus unde! Non inventore voluptas molestiae in, explicabo dolorum quas, accusamus temporibus ducimus voluptatibus, suscipit accusantium aliquam magni?",
    //   "hasil_pengukuran": ["Sistol (mmHg)", "Diastol (mmHg)"],
    // }
  ].obs;

  Future<void> savePengecekan(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Simpan Pengecekan"),
          content: const Text("Apakah anda ingin menyimpan data pengecekan ?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: () async {
                if (sensorService.dataSensorCoba.length < 5) {
                  AppUtils.toast("Silahkan lengkapi dulu semua data",
                      AppColors.dangerColor);

                  Navigator.of(context).pop();
                  return;
                }

                try {
                  isLoading.value = true;

                  Map<String, dynamic> user = AppUtils.convertJsonFormat(
                      jsonDecode(jsonEncode(
                          await secureStorageService.getDataUser())));
                  var token = await secureStorageService.getToken();

                  // data yang harus diisi
                  Map parameterInput = {
                    "blood_oxygen": null,
                    "heart_rate": null,
                    "body_mass_index": null,
                    "body_weight": null,
                    'body_temperature': null,
                    'blood_pressure': [
                      {
                        "duration": 70,
                        "start_at": "2023-10-16T01:33:49.287Z",
                        "end_at": "2023-10-16T02:34:49.287Z",
                        "error": false,
                        "status": "kurang normal",
                        "value": "99/81"
                      }
                    ],
                    'blood_sugar': [
                      {
                        "duration": 70,
                        "start_at": "2023-10-16T01:33:49.287Z",
                        "end_at": "2023-10-16T02:34:49.287Z",
                        "error": false,
                        "status": "kurang normal",
                        "value": "40"
                      }
                    ],
                    'cholesterol': [
                      {
                        "duration": 70,
                        "start_at": "2023-10-16T01:33:49.287Z",
                        "end_at": "2023-10-16T02:34:49.287Z",
                        "error": false,
                        "status": "kurang normal",
                        "value": "40"
                      }
                    ],
                    'hemoglobin': [
                      {
                        "duration": 70,
                        "start_at": "2023-10-16T01:33:49.287Z",
                        "end_at": "2023-10-16T02:34:49.287Z",
                        "error": false,
                        "status": "kurang normal",
                        "value": "40"
                      }
                    ],
                    'uric_acid': [
                      {
                        "duration": 70,
                        "start_at": "2023-10-16T01:33:49.287Z",
                        "end_at": "2023-10-16T02:34:49.287Z",
                        "error": false,
                        "status": "kurang normal",
                        "value": "40"
                      }
                    ],
                  };
                  // filter data
                  parameterInput.forEach((key, value) {
                    if (sensorService.dataSensorCoba[key] != null) {
                      parameterInput[key] = sensorService.dataSensorCoba[key];
                    }
                  });
                  // data post
                  Map dataPost = {
                    "uuid": user['userId'].toString(),
                    ...parameterInput
                  };
                  await Dio().post(
                    "${AppBaseUrl.url}/sensor",
                    data: dataPost,
                    options: Options(
                      headers: {
                        'Content-Type': 'application/json',
                        "Authorization": token.toString(),
                      },
                    ),
                  );

                  sensorService.dataSensorCoba.clear();

                  AppUtils.toast(
                      "Data berhasil tersimpan !", AppColors.primaryColor);

                  isLoading.value = false;

                  Navigator.of(context).pop();
                } catch (e) {
                  isLoading.value = false;
                  debugPrint(e.toString());
                  if (e is DioException) {
                    if (e.response?.statusCode == 401) {
                      AppUtils.toast(e.response!.statusMessage.toString(),
                          AppColors.dangerColor);
                      // hapus token lalu logout
                      await secureStorageService.deleteToken();
                      Get.offAndToNamed(Routes.LOGIN);
                    } else if (e.type == DioExceptionType.connectionError) {
                      AppUtils.toast("Tidak ada koneksi internet !",
                          AppColors.dangerColor);
                    } else if (e.type == DioExceptionType.badResponse) {
                      AppUtils.toast("Terdapat kesalahan pada sistem !",
                          AppColors.dangerColor);
                    } else if (e.type == DioExceptionType.badCertificate) {
                      AppUtils.toast("Terdapat kesalahan pada sistem !",
                          AppColors.dangerColor);
                    }
                  } else {
                    AppUtils.toast("Terdapat kesalahan pada sistem !",
                        AppColors.dangerColor);
                    debugPrint(e.toString());
                  }

                  Navigator.of(context).pop();
                }
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkBluetoothIsOn(
      BuildContext context,
      String deviceID,
      String characteristicID,
      String? nama,
      String? imageUrl,
      dynamic hasilPengukuran) async {
    // mengecek bluetooth
    if (await FlutterBluePlus.isSupported == false) {
      AppUtils.toast(
          "Bluetooth not supported by this device !", AppColors.dangerColor);
      return;
    }

    // mengecek permission bluetooth
    var statusBluetoothLocation = await Permission.location.request();
    if (statusBluetoothLocation.isPermanentlyDenied) {
      void action() {
        openAppSettings();
      }

      AppUtils.confirmDialog(
          context,
          "Izin Lokasi Diperlukan",
          "Untuk menggunakan fitur ini, Anda perlu mengizinkan akses ke lokasi di pengaturan aplikasi.",
          "Buka Pengaturan",
          action,
          true);
      return;
    }

    /// Pengecekan bluetooth apakah sudah on
    StreamSubscription<BluetoothAdapterState>? adapterStateSubscription;
    adapterStateSubscription = FlutterBluePlus.adapterState
        .listen((BluetoothAdapterState state) async {
      if (state == BluetoothAdapterState.on) {
        Navigator.pop(context);

        // check if device is connected
        if (connectDeviceVM.connectedDevice.value != null) {
          await connectDeviceVM.connectedDevice.value!.disconnect();
          connectDeviceVM.connectedDevice.value = null;
        }

        // mematikan pengecekan bluetooth
        await adapterStateSubscription!.cancel();

        Get.toNamed(Routes.CONNECT_DEVICE, arguments: {
          "nama": nama,
          "img_url": imageUrl,
          "deviceID": deviceID,
          "characteristicID": characteristicID,
          "hasil_pengukuran": hasilPengukuran,
        });
      } else if (state == BluetoothAdapterState.off) {
        AppUtils.toast(
            "Anda belum menghidupkan bluetooth !", AppColors.dangerColor);

        await adapterStateSubscription!.cancel();

        Navigator.pop(context);
      } else if (state == BluetoothAdapterState.turningOn) {
        AppUtils.toast(
            "Sedang proses menghidupkan bluetooth...", AppColors.primaryColor);

        await adapterStateSubscription!.cancel();

        Navigator.pop(context);
      } else if (state == BluetoothAdapterState.unauthorized) {
        AppUtils.toast("Aktifkan perizinan bluetooth !", AppColors.dangerColor);

        await adapterStateSubscription!.cancel();

        Navigator.pop(context);
      } else {
        AppUtils.toast(state.toString(), AppColors.dangerColor);

        await adapterStateSubscription!.cancel();

        Navigator.pop(context);
      }
    });
  }
}
