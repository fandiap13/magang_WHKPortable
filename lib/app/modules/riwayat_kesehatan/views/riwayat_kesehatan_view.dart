import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wish/app/modules/riwayat_kesehatan/views/widgets/riwayat_kesehatan_card.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/app_bar_component.dart';
import 'package:wish/app/resources/components/my_loader_screen_component.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:wish/app/services/login_services.dart';

import '../controllers/riwayat_kesehatan_controller.dart';

class RiwayatKesehatanView extends StatefulWidget {
  const RiwayatKesehatanView({Key? key}) : super(key: key);

  @override
  State<RiwayatKesehatanView> createState() => _RiwayatKesehatanViewState();
}

class _RiwayatKesehatanViewState extends State<RiwayatKesehatanView> {
  final riwayatKesehatanVM = Get.put(RiwayatKesehatanController());
  final loginService = LoginService();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      loadData();
    });
  }

  Future<void> loadData() async {
    await loginService.isLoggedOut();
    await riwayatKesehatanVM.getNewstSensor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarComponent(
          title: "Riwayat Kesehatan",
          automaticallyImplyLeading: false,
        ),
        body: Obx(
          () => riwayatKesehatanVM.isLoading.value == true
              ? const MyLoaderScreen()
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Builder(builder: (context) {
                      if (riwayatKesehatanVM.statusData.value == false) {
                        return Center(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 40.0),
                              child: Text(
                                "Data kosong...",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryColor,
                                    fontSize: 20.0),
                              )),
                        );
                      }

                      return Column(
                        children: [
                          if (riwayatKesehatanVM.bloodOxygen.isNotEmpty &&
                              riwayatKesehatanVM.heartRate.isNotEmpty)
                            RiwayatKesehatanCard(
                              durationMiliSec: 600,
                              id: 1,
                              title: "Oksimeter",
                              icon: Icons.monitor_heart_rounded,
                              tanggal: DateFormat('dd MMM y').format(
                                  DateTime.parse(riwayatKesehatanVM
                                      .bloodOxygen['start_at'])),
                              jam: DateFormat('HH:mm').format(DateTime.parse(
                                  riwayatKesehatanVM.bloodOxygen['start_at'])),
                              status: riwayatKesehatanVM.bloodOxygen['status'],
                              value1: {
                                "title": "Oksigen Darah",
                                "value":
                                    riwayatKesehatanVM.bloodOxygen['value'],
                                "satuan": "%"
                              },
                              value2: {
                                "title": "Detak Jantung",
                                "value": riwayatKesehatanVM.heartRate['value'],
                                "satuan": "denyut/menit"
                              },
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_RIWAYAT_KESEHATAN,
                                    arguments: {
                                      "id": 1,
                                      "title": "Oksimeter",
                                      "icon": Icons.monitor_heart_rounded,
                                      'tanggal': DateFormat('dd MMM y').format(
                                          DateTime.parse(riwayatKesehatanVM
                                              .bloodOxygen['start_at'])),
                                      'jam': DateFormat('HH:mm').format(
                                          DateTime.parse(riwayatKesehatanVM
                                              .bloodOxygen['start_at'])),
                                      'status': riwayatKesehatanVM
                                          .bloodOxygen['status'],
                                      'value1': {
                                        "title": "Oksigen Darah",
                                        "value": riwayatKesehatanVM
                                            .bloodOxygen['value'],
                                        "satuan": "%"
                                      },
                                      'value2': {
                                        "title": "Detak Jantung",
                                        "value": riwayatKesehatanVM
                                            .heartRate['value'],
                                        "satuan": "denyut/menit"
                                      },
                                      "data_riwayat":
                                          "/sensor/oxygen/${riwayatKesehatanVM.userID.value}",
                                      "type": ["blood_oxygen", "heart_rate"],
                                      "subtitle": [
                                        "Oksigen Darah",
                                        "Detak Jantung"
                                      ],
                                    });
                              },
                            ),
                          if (riwayatKesehatanVM.bodyTemperature.isNotEmpty)
                            RiwayatKesehatanCard(
                              durationMiliSec: 700,
                              id: 2,
                              title: "Termometer",
                              icon: Icons.thermostat,
                              tanggal: DateFormat('dd MMM y').format(
                                  DateTime.parse(riwayatKesehatanVM
                                      .bodyTemperature['start_at'])),
                              jam: DateFormat('HH:mm').format(DateTime.parse(
                                  riwayatKesehatanVM
                                      .bodyTemperature['start_at'])),
                              status:
                                  riwayatKesehatanVM.bodyTemperature['status'],
                              value1: {
                                "title": "Suhu Tubuh",
                                "value":
                                    riwayatKesehatanVM.bodyTemperature['value'],
                                "satuan": "°C"
                              },
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_RIWAYAT_KESEHATAN,
                                    arguments: {
                                      "id": 2,
                                      "title": "Termometer",
                                      "icon": Icons.thermostat,
                                      'tanggal': DateFormat('dd MMM y').format(
                                          DateTime.parse(riwayatKesehatanVM
                                              .bodyTemperature['start_at'])),
                                      'jam': DateFormat('HH:mm').format(
                                          DateTime.parse(riwayatKesehatanVM
                                              .bodyTemperature['start_at'])),
                                      'status': riwayatKesehatanVM
                                          .bodyTemperature['status'],
                                      "value1": {
                                        "title": "Suhu Tubuh",
                                        "value": riwayatKesehatanVM
                                            .bodyTemperature['value'],
                                        "satuan": "°C"
                                      },
                                      "data_riwayat":
                                          "/sensor/oxygen/${riwayatKesehatanVM.userID.value}",
                                      "type": ["blood_oxygen", "heart_rate"],
                                      "subtitle": [
                                        "Oksigen Darah",
                                        "Detak Jantung"
                                      ],
                                    });
                              },
                            ),
                          if (riwayatKesehatanVM.bodyMassIndex.isNotEmpty &&
                              riwayatKesehatanVM.bodyWeight.isNotEmpty)
                            RiwayatKesehatanCard(
                              durationMiliSec: 900,
                              id: 3,
                              title: "Berat Badan",
                              icon: Icons.monitor_weight,
                              tanggal: DateFormat('dd MMM y').format(
                                  DateTime.parse(riwayatKesehatanVM
                                      .bodyWeight['start_at'])),
                              jam: DateFormat('HH:mm').format(DateTime.parse(
                                  riwayatKesehatanVM.bodyWeight['start_at'])),
                              status:
                                  riwayatKesehatanVM.bodyMassIndex['status'],
                              value1: {
                                "title": "Berat Badan",
                                "value": riwayatKesehatanVM.bodyWeight['value'],
                                "satuan": "kg"
                              },
                              value2: {
                                "title": "BMI",
                                "value":
                                    riwayatKesehatanVM.bodyMassIndex['value'],
                                "satuan": "kg/M2"
                              },
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_RIWAYAT_KESEHATAN,
                                    arguments: {
                                      "id": 3,
                                      "title": "Berat Badan",
                                      "icon": Icons.monitor_weight,
                                      'tanggal': DateFormat('dd MMM y').format(
                                          DateTime.parse(riwayatKesehatanVM
                                              .bodyWeight['start_at'])),
                                      'jam': DateFormat('HH:mm').format(
                                          DateTime.parse(riwayatKesehatanVM
                                              .bodyWeight['start_at'])),
                                      'status': riwayatKesehatanVM
                                          .bodyMassIndex['status'],
                                      "value1": {
                                        "title": "Berat Badan",
                                        "value": riwayatKesehatanVM
                                            .bodyWeight['value'],
                                        "satuan": "kg"
                                      },
                                      "value2": {
                                        "title": "BMI",
                                        "value": riwayatKesehatanVM
                                            .bodyMassIndex['value'],
                                        "satuan": "kg/M2"
                                      },
                                      "data_riwayat":
                                          "/sensor/weight/${riwayatKesehatanVM.userID.value}",
                                      "type": [
                                        "body_weight",
                                        "body_mass_index"
                                      ],
                                      "subtitle": ["Berat badan", "BMI"],
                                    });
                              },
                            ),
                          if (riwayatKesehatanVM.bloodPressure.isNotEmpty)
                            RiwayatKesehatanCard(
                              durationMiliSec: 1000,
                              id: 4,
                              title: "Tekanan Darah",
                              icon: Icons.bloodtype,
                              tanggal: DateFormat('dd MMM y').format(
                                  DateTime.parse(riwayatKesehatanVM
                                      .bloodPressure['start_at'])),
                              jam: DateFormat('HH:mm').format(DateTime.parse(
                                  riwayatKesehatanVM
                                      .bloodPressure['start_at'])),
                              status:
                                  riwayatKesehatanVM.bodyMassIndex['status'],
                              value1: {
                                "title": "Sistol",
                                "value": riwayatKesehatanVM
                                    .bloodPressure['value']
                                    .split("/")[0],
                                "satuan": "mmHg"
                              },
                              value2: {
                                "title": "Diastol",
                                "value": riwayatKesehatanVM
                                    .bloodPressure['value']
                                    .split("/")[1],
                                "satuan": "mmHg"
                              },
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_RIWAYAT_KESEHATAN,
                                    arguments: {
                                      "id": 3,
                                      "title": "Tekanan Darah",
                                      "icon": Icons.monitor_weight,
                                      'tanggal': DateFormat('dd MMM y').format(
                                          DateTime.parse(riwayatKesehatanVM
                                              .bloodPressure['start_at'])),
                                      'jam': DateFormat('HH:mm').format(
                                          DateTime.parse(riwayatKesehatanVM
                                              .bloodPressure['start_at'])),
                                      'status': riwayatKesehatanVM
                                          .bodyMassIndex['status'],
                                      "value1": {
                                        "title": "Sistol",
                                        "value": riwayatKesehatanVM
                                            .bloodPressure['value']
                                            .split("/")[0],
                                        "satuan": "mmHg"
                                      },
                                      "value2": {
                                        "title": "Diastol",
                                        "value": riwayatKesehatanVM
                                            .bloodPressure['value']
                                            .split("/")[1],
                                        "satuan": "mmHg"
                                      },
                                      "data_riwayat":
                                          "/sensor/pressure/${riwayatKesehatanVM.userID.value}",
                                      "type": ["blood_pressure"],
                                      "subtitle": [
                                        "Sistol",
                                        "Diastol",
                                      ],
                                    });
                              },
                            ),
                        ],
                      );
                    }),
                  ),
                ),
        ));
  }
}
