import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/routes/app_pages.dart';

class ConnectDeviceController extends GetxController {
  final Rx<BluetoothDevice?> connectedDevice = Rx<BluetoothDevice?>(null);
  final RxList<ScanResult> scanResultList = <ScanResult>[].obs;
  StreamSubscription<List<ScanResult>>? subscription;
  final RxBool isScanning = false.obs;
  final RxBool isConnecting = false.obs;

  Future<void> searchDevice(dataArgument) async {
    // bersihkan scan result
    scanResultList.clear();

    // melihat status scanning
    FlutterBluePlus.isScanning.listen((event) async {
      isScanning.value = event;
    });

    // scan device bluetooth
    subscription = FlutterBluePlus.scanResults.listen((scanResult) {
      scanResultList.value = scanResult;
      if (scanResult.isNotEmpty) {
        filterDevice(scanResult, dataArgument);
      }
    }, onError: (e) {
      debugPrint(e.toString());
    });

    // mulai scan
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    // matikan scan ketika sudah 4 detik
    Timer(const Duration(seconds: 4), () async {
      await subscription!.cancel();
      await FlutterBluePlus.stopScan();

      // mencari perangkat yang terdeteksi
      if (connectedDevice.value == null || connectedDevice.value == "") {
        AppUtils.toast("Perangkat tidak ditemukan !", AppColors.dangerColor);
      }
      // else {
      //   print(connectedDevice.value);
      //   print(isScanning.value);
      // }

      // else {
      //   // jika terdeteksi silahkan dikoneksikan
      //   await connectToDevice(
      //       dataArgument['characteristicID'],
      //       dataArgument['nama'],
      //       dataArgument['img_url'],
      //       dataArgument['hasil_pengukuran']);
      // }
    });
  }

  Future<void> filterDevice(scanResult, dataArgument) async {
    for (ScanResult element in scanResult) {
      if (element.device.remoteId.toString() == dataArgument['deviceID']) {
        connectedDevice.value = element.device;
        break;
      }
    }
  }

  Future<void> connectToDevice(String characteristicID, String nama,
      String? imageUrl, dynamic hasilPengukuran) async {
    // print(hasilPengukuran);
    // return;
    if (hasilPengukuran == null) {
      AppUtils.toast("Hasil pengukuran pada device belum ditentukan !",
          AppColors.dangerColor);
      return;
    }

    isConnecting.value = true;
    try {
      await connectedDevice.value!.connect();
      isConnecting.value = false;
      isScanning.value = false;
      // AppUtils.toast("Perangkat berhasil tersambung", null);

      Get.offAndToNamed(Routes.HASIL_PENGUKURAN, arguments: {
        'characteristicID': characteristicID,
        'nama': nama,
        'img_url': imageUrl,
        'hasil_pengukuran': hasilPengukuran
      });
    } catch (e) {
      isConnecting.value = false;
      connectedDevice.value = null;
      AppUtils.toast("Perangkat gagal tersambung !", AppColors.dangerColor);
      debugPrint("Errornya: $e");
    }
  }
}
