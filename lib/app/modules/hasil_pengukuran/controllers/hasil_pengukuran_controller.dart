import 'dart:async';
import 'dart:math';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:wish/app/modules/connect_device/controllers/connect_device_controller.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/services/sensor_service.dart';

class HasilPengukuranController extends GetxController {
  final connectDeviceVM = Get.put(ConnectDeviceController());
  final sensorService = Get.put(SensorService());

  final RxDouble value1 = 0.0.obs;
  final RxDouble value2 = 0.0.obs;
  final RxDouble valueDitampilkan1 = 0.0.obs;
  final RxDouble valueDitampilkan2 = 0.0.obs;

  final RxBool isLoading = true.obs;

  Future<void> readDataSensor(
      String characteristicID, String nama, dynamic hasilPengukuran) async {
    // clear
    valueDitampilkan1.value = 0.0;
    valueDitampilkan2.value = 0.0;
    // input
    final startAt = DateTime.now();
    isLoading.value = true;

    List<BluetoothService> services =
        await connectDeviceVM.connectedDevice.value!.discoverServices();
    BluetoothCharacteristic? targetCharacteristic;
    StreamSubscription<List<int>>? subscription;
    // search notify
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == characteristicID) {
          targetCharacteristic = characteristic;
          break;
        }
      }
    }

    // read data from notify
    subscription =
        targetCharacteristic?.onValueReceived.listen((List<int> value) async {
      // debugPrint(nama.toLowerCase());
      // data yang ditampilkan sementara
      if (nama.toLowerCase() == "oksimeter") {
        valueDitampilkan1.value = value[7].toDouble();
        valueDitampilkan2.value = value[6].toDouble();
        if (value.length == 10) {
          isLoading.value = true;
          value1.value = value[5].toDouble();
          value2.value = value[4].toDouble();
        }
      } else if (nama.toLowerCase() == "berat badan") {
        if (value.length == 14) {
          isLoading.value = true;
          int data1 = value[7];
          int data2 = value[8];
          double hasil = (data1 << 8 | data2) / 10;
          // berat badan
          value1.value = hasil;
        }
      } else if (nama.toLowerCase() == "termometer") {
        isLoading.value = true;
        value1.value = (value[2] << 8 | value[1]) / 100;
        isLoading.value = false;
        // jika tidak kosong maka hentikan
        if (value1.value != 0.0) {
          saveDataSensor(nama, startAt);
          await connectDeviceVM.connectedDevice.value!.disconnect();
        }
      }

      // jika bukan termometer perintah ini akan dijalankan
      if (nama.toLowerCase() != "termometer") {
        // jalankan scan ketika notify didapatkan
        // matikan scan ketika sudah 5 detik
        Timer(const Duration(seconds: 5), () async {
          // proses lain
          if (connectDeviceVM.connectedDevice.value != null) {
            // PROSES PENYIMPANAN DATA KETIKA DATA BERHASIL DIDAPATKAN
            if (value1.value != 0.0) {
              saveDataSensor(nama, startAt);
            } else {
              AppUtils.toast(
                  "Data tidak dapat disimpan !", AppColors.dangerColor);
              isLoading.value = false;
            }

            // await targetCharacteristic!.setNotifyValue(false);
            // await subscription?.cancel();
            await connectDeviceVM.connectedDevice.value!.disconnect();
          }
        });
      }
    });

    // matikan notify ketika perangkat tidak terdeteksi
    // mulai start notify
    await targetCharacteristic?.setNotifyValue(true);

    // cek koneksi dengan device
    // ketika koneksi terputus
    StreamSubscription<BluetoothConnectionState>? subscriptionForStatus;
    subscriptionForStatus = connectDeviceVM
        .connectedDevice.value!.connectionState
        .listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        connectDeviceVM.connectedDevice.value = null;
        isLoading.value = false;
        subscriptionForStatus!.cancel();
      }
    });
  }

  // fungsi menyimpan data sensor
  void saveDataSensor(String nama, startAt) {
    final endAt = DateTime.now();
    Duration difference = endAt.difference(startAt);
    int differentInSeconds = difference.inSeconds;
    // Simpan data sensor ke local storage / sementara
    if (nama.toLowerCase() == "oksimeter") {
      late String status;
      int oxygenLevel = value1.value.toInt();
      int heartRate = value2.value.toInt();
      if (oxygenLevel >= 95 && heartRate >= 60 && heartRate <= 100) {
        status = 'Normal';
      } else if (oxygenLevel >= 90 && heartRate >= 50 && heartRate <= 120) {
        status = 'Kurang normal';
      } else {
        status = 'Tidak normal';
      }
      sensorService.setSensor2({
        "blood_oxygen": [
          {
            "duration": differentInSeconds.toString(),
            "start_at": startAt.toString(),
            "end_at": endAt.toString(),
            "error": false,
            "status": status,
            "value": value1.value
          },
        ],
        "heart_rate": [
          {
            "duration": differentInSeconds.toString(),
            "start_at": startAt.toString(),
            "end_at": endAt.toString(),
            "error": false,
            "status": status,
            "value": value2.value
          }
        ]
      });
    } else if (nama.toLowerCase() == "berat badan") {
      int tinggi = 170;
      double bmi = double.parse(
          (value1.value / pow((tinggi / 100), 2)).toStringAsFixed(2));
      value2.value = bmi;
      late String status;
      if (value2.value < 18.5) {
        status = 'Kurus';
      } else if (value2.value >= 18.5 && value2.value < 24.9) {
        status = 'Normal';
      } else if (value2.value >= 25.0 && value2.value < 29.9) {
        status = 'Gemuk';
      } else {
        status = 'Obesitas';
      }
      sensorService.setSensor2({
        "body_weight": [
          {
            "duration": differentInSeconds.toString(),
            "start_at": startAt.toString(),
            "end_at": endAt.toString(),
            "error": false,
            "status": status,
            "value": value1.value
          },
        ],
        "body_mass_index": [
          {
            "duration": differentInSeconds.toString(),
            "start_at": startAt.toString(),
            "end_at": endAt.toString(),
            "error": false,
            "status": status,
            "value": value2.value
          }
        ]
      });
    } else if (nama.toLowerCase() == "termometer") {
      late String status;
      if (value1.value >= 35.5 && value1.value <= 37.5) {
        status = 'Normal';
      } else if (value2.value > 37.5) {
        status = 'Demam';
      } else {
        status = 'Hipotermia';
      }
      sensorService.setSensor2({
        "body_temperature": [
          {
            "duration": differentInSeconds.toString(),
            "start_at": startAt.toString(),
            "end_at": endAt.toString(),
            "error": false,
            "status": status,
            "value": value1.value
          },
        ],
      });
    } else {
      AppUtils.toast("Data tidak dapat disimpan !", AppColors.dangerColor);
    }

    isLoading.value = false;
  }
}
