import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wish/app/modules/home/controllers/home_controller.dart';
import 'package:wish/app/modules/home/views/widget/card_pengecekan.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/header_component.dart';
import 'package:wish/app/resources/components/header_text.dart';
import 'package:wish/app/resources/components/my_loader_screen_component.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:wish/app/services/login_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final loginService = LoginService();
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      loadData();
    });
  }

  Future<void> loadData() async {
    await loginService.isLoggedOut();
    await homeController.getName();
    await homeController.getNewstSensor();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => homeController.isLoading.value == true
              ? const MyLoaderScreen()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Component
                      HeaderComponent(
                        name: homeController.name.value,
                      ),

                      /// MAIN CONTENT
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: const HeaderText(
                                headerText1: "Hasil Pengecekan",
                                headerText2: "Pengecekan terakhir anda.",
                              ),
                            ),
                            Builder(builder: (context) {
                              if (homeController.statusData.value == false) {
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
                                  const SizedBox(
                                    height: 35.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (homeController
                                              .bloodOxygen.isNotEmpty &&
                                          homeController.heartRate.isNotEmpty)
                                        Expanded(
                                          child: CardHome(
                                            title: "Oksimeter",
                                            icon: Icons.monitor_heart_rounded,
                                            tanggal: DateFormat('dd MMM y')
                                                .format(DateTime.parse(
                                                    homeController.bloodOxygen[
                                                        'start_at'])),
                                            jam: DateFormat('HH:mm').format(
                                                DateTime.parse(homeController
                                                    .bloodOxygen['start_at'])),
                                            status: homeController
                                                .bloodOxygen['status']
                                                .toString(),
                                            hasilPengecekan: [
                                              {
                                                "title": "Oksigen Darah",
                                                "value": homeController
                                                    .bloodOxygen['value'],
                                                "satuan": "%"
                                              },
                                              {
                                                "title": "Detak Jantung",
                                                "value": homeController
                                                    .heartRate['value'],
                                                "satuan": "denyut/menit"
                                              },
                                            ],
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes
                                                      .DETAIL_RIWAYAT_KESEHATAN,
                                                  arguments: {
                                                    "id": 1,
                                                    "title": "Oksimeter",
                                                    "icon": Icons
                                                        .monitor_heart_rounded,
                                                    'tanggal': DateFormat(
                                                            'dd MMM y')
                                                        .format(DateTime.parse(
                                                            homeController
                                                                    .bloodOxygen[
                                                                'start_at'])),
                                                    'jam': DateFormat('HH:mm')
                                                        .format(DateTime.parse(
                                                            homeController
                                                                    .bloodOxygen[
                                                                'start_at'])),
                                                    'status': homeController
                                                        .bloodOxygen['status'],
                                                    'value1': {
                                                      "title": "Oksigen Darah",
                                                      "value": homeController
                                                          .bloodOxygen['value'],
                                                      "satuan": "%"
                                                    },
                                                    'value2': {
                                                      "title": "Detak Jantung",
                                                      "value": homeController
                                                          .heartRate['value'],
                                                      "satuan": "denyut/menit"
                                                    },
                                                    "data_riwayat":
                                                        "/sensor/oxygen/${homeController.userID.value}",
                                                    "type": [
                                                      "blood_oxygen",
                                                      "heart_rate"
                                                    ],
                                                    "subtitle": [
                                                      "Oksigen Darah",
                                                      "Detak Jantung"
                                                    ],
                                                  });
                                            },
                                          ),
                                        ),
                                      if (homeController
                                              .bloodOxygen.isNotEmpty &&
                                          homeController.heartRate.isNotEmpty &&
                                          homeController
                                              .bodyTemperature.isNotEmpty)
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                      if (homeController
                                          .bodyTemperature.isNotEmpty)
                                        Expanded(
                                          child: CardHome(
                                            title: "Termometer",
                                            icon: Icons.thermostat,
                                            tanggal: DateFormat('dd MMM y')
                                                .format(DateTime.parse(
                                                    homeController
                                                            .bodyTemperature[
                                                        'start_at'])),
                                            jam: DateFormat('HH:mm').format(
                                                DateTime.parse(homeController
                                                        .bodyTemperature[
                                                    'start_at'])),
                                            status: homeController
                                                .bodyTemperature['status'],
                                            hasilPengecekan: [
                                              {
                                                "title": "Suhu Tubuh",
                                                "value": homeController
                                                    .bodyTemperature['value'],
                                                "satuan": "°C"
                                              },
                                            ],
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes
                                                      .DETAIL_RIWAYAT_KESEHATAN,
                                                  arguments: {
                                                    "id": 2,
                                                    "title": "Termometer",
                                                    "icon": Icons.thermostat,
                                                    'tanggal': DateFormat(
                                                            'dd MMM y')
                                                        .format(DateTime.parse(
                                                            homeController
                                                                    .bodyTemperature[
                                                                'start_at'])),
                                                    'jam': DateFormat('HH:mm')
                                                        .format(DateTime.parse(
                                                            homeController
                                                                    .bodyTemperature[
                                                                'start_at'])),
                                                    'status': homeController
                                                            .bodyTemperature[
                                                        'status'],
                                                    "value1": {
                                                      "title": "Suhu Tubuh",
                                                      "value": homeController
                                                              .bodyTemperature[
                                                          'value'],
                                                      "satuan": "°C"
                                                    },
                                                    "data_riwayat":
                                                        "/sensor/oxygen/${homeController.userID.value}",
                                                    "type": [
                                                      "blood_oxygen",
                                                      "heart_rate"
                                                    ],
                                                    "subtitle": [
                                                      "Oksigen Darah",
                                                      "Detak Jantung"
                                                    ],
                                                  });
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (homeController
                                              .bodyWeight.isNotEmpty &&
                                          homeController
                                              .bodyMassIndex.isNotEmpty)
                                        Expanded(
                                          child: CardHome(
                                            title: "Berat Badan",
                                            icon: Icons.monitor_weight_outlined,
                                            tanggal: DateFormat('dd MMM y')
                                                .format(DateTime.parse(
                                                    homeController
                                                            .bodyMassIndex[
                                                        'start_at'])),
                                            jam: DateFormat('HH:mm').format(
                                                DateTime.parse(homeController
                                                        .bodyMassIndex[
                                                    'start_at'])),
                                            status: homeController
                                                .bodyMassIndex['status'],
                                            hasilPengecekan: [
                                              {
                                                "title": "Berat Badan",
                                                "value": homeController
                                                    .bodyWeight['value'],
                                                "satuan": "kg"
                                              },
                                              {
                                                "title": "BMI",
                                                "value": homeController
                                                    .bodyMassIndex['value'],
                                                "satuan": "kg/M2"
                                              },
                                            ],
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes
                                                      .DETAIL_RIWAYAT_KESEHATAN,
                                                  arguments: {
                                                    "id": 3,
                                                    "title": "Berat Badan",
                                                    "icon":
                                                        Icons.monitor_weight,
                                                    'tanggal': DateFormat(
                                                            'dd MMM y')
                                                        .format(DateTime.parse(
                                                            homeController
                                                                    .bodyWeight[
                                                                'start_at'])),
                                                    'jam': DateFormat('HH:mm')
                                                        .format(DateTime.parse(
                                                            homeController
                                                                    .bodyWeight[
                                                                'start_at'])),
                                                    'status': homeController
                                                            .bodyMassIndex[
                                                        'status'],
                                                    "value1": {
                                                      "title": "Berat Badan",
                                                      "value": homeController
                                                          .bodyWeight['value'],
                                                      "satuan": "kg"
                                                    },
                                                    "value2": {
                                                      "title": "BMI",
                                                      "value": homeController
                                                              .bodyMassIndex[
                                                          'value'],
                                                      "satuan": "kg/M2"
                                                    },
                                                    "data_riwayat":
                                                        "/sensor/weight/${homeController.userID.value}",
                                                    "type": [
                                                      "body_weight",
                                                      "body_mass_index"
                                                    ],
                                                    "subtitle": [
                                                      "Berat badan",
                                                      "BMI"
                                                    ],
                                                  });
                                            },
                                          ),
                                        ),
                                      if (homeController
                                              .bodyMassIndex.isNotEmpty &&
                                          homeController
                                              .bodyWeight.isNotEmpty &&
                                          homeController
                                              .bloodPressure.isNotEmpty)
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                      if (homeController
                                          .bloodPressure.isNotEmpty)
                                        Expanded(
                                          child: CardHome(
                                            title: "Tekanan Darah",
                                            icon: Icons.bloodtype,
                                            tanggal: DateFormat('dd MMM y')
                                                .format(DateTime.parse(
                                                    homeController
                                                            .bloodPressure[
                                                        'start_at'])),
                                            jam: DateFormat('HH:mm').format(
                                                DateTime.parse(homeController
                                                        .bloodPressure[
                                                    'start_at'])),
                                            status: homeController
                                                .bloodPressure['status'],
                                            hasilPengecekan: [
                                              {
                                                "title": "Sistol",
                                                "value": homeController
                                                    .bloodPressure['value']
                                                    .split("/")[0],
                                                "satuan": "mmHg"
                                              },
                                              {
                                                "title": "Diastol",
                                                "value": homeController
                                                    .bloodPressure['value']
                                                    .split("/")[1],
                                                "satuan": "mmHg"
                                              },
                                            ],
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes
                                                      .DETAIL_RIWAYAT_KESEHATAN,
                                                  arguments: {
                                                    "id": 3,
                                                    "title": "Tekanan Darah",
                                                    "icon":
                                                        Icons.monitor_weight,
                                                    'tanggal': DateFormat(
                                                            'dd MMM y')
                                                        .format(DateTime.parse(
                                                            homeController
                                                                    .bloodPressure[
                                                                'start_at'])),
                                                    'jam': DateFormat('HH:mm')
                                                        .format(DateTime.parse(
                                                            homeController
                                                                    .bloodPressure[
                                                                'start_at'])),
                                                    'status': homeController
                                                            .bodyMassIndex[
                                                        'status'],
                                                    "value1": {
                                                      "title": "Sistol",
                                                      "value": homeController
                                                          .bloodPressure[
                                                              'value']
                                                          .split("/")[0],
                                                      "satuan": "mmHg"
                                                    },
                                                    "value2": {
                                                      "title": "Diastol",
                                                      "value": homeController
                                                          .bloodPressure[
                                                              'value']
                                                          .split("/")[1],
                                                      "satuan": "mmHg"
                                                    },
                                                    "data_riwayat":
                                                        "/sensor/pressure/${homeController.userID.value}",
                                                    "type": ["blood_pressure"],
                                                    "subtitle": [
                                                      "Sistol",
                                                      "Diastol",
                                                    ],
                                                  });
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              );
                            }),

                            // BERI ULASAN
                            // const SizedBox(
                            //   height: 20.0,
                            // ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: AppColors.grey2.withOpacity(0.2),
                            //         spreadRadius: 1,
                            //         blurRadius: 5,
                            //         offset: const Offset(
                            //             0, 1), // changes position of shadow
                            //       ),
                            //     ],
                            //   ),
                            //   padding: const EdgeInsets.symmetric(
                            //       vertical: 10.0, horizontal: 15.0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         "Ulasan",
                            //         style: GoogleFonts.poppins(
                            //             fontWeight: FontWeight.w500,
                            //             fontSize: 18.0,
                            //             color: AppColors.secondaryColor),
                            //       ),
                            //       ElevatedButton(
                            //           onPressed: () {
                            //             Get.toNamed(Routes.KIRIM_ULASAN);
                            //           },
                            //           style: ButtonStyle(
                            //             padding: MaterialStateProperty.all<
                            //                     EdgeInsetsGeometry>(
                            //                 const EdgeInsets.symmetric(
                            //                     horizontal: 15, vertical: 10)),
                            //             backgroundColor: MaterialStateProperty
                            //                 .all<Color>(AppColors
                            //                     .primaryColor), // Background color
                            //             shape: MaterialStateProperty.all<
                            //                 RoundedRectangleBorder>(
                            //               RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.circular(
                            //                     10.0), // Border radius
                            //               ),
                            //             ),
                            //           ),
                            //           child: Text("Beri Ulasan",
                            //               style: GoogleFonts.poppins(
                            //                   fontWeight: FontWeight.w500,
                            //                   fontSize: 18.0)))
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
