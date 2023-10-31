import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/modules/hasil_pengukuran/views/widget/card_hasil.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/app_bar_component.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:wish/app/services/sensor_service.dart';

import '../controllers/hasil_pengukuran_controller.dart';

class HasilPengukuranView extends StatefulWidget {
  const HasilPengukuranView({Key? key}) : super(key: key);

  @override
  State<HasilPengukuranView> createState() => _HasilPengukuranViewState();
}

class _HasilPengukuranViewState extends State<HasilPengukuranView> {
  final hasilPengukuranVM = Get.put(HasilPengukuranController());
  final sensorService = Get.put(SensorService());

  var data = Get.arguments;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      cekPengukuran();
    });
    super.initState();
  }

  void cekPengukuran() {
    hasilPengukuranVM.readDataSensor(
        data['characteristicID'], data['nama'], data['hasil_pengukuran']);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarComponent(
          title: "Pengecekan ${data['nama']}",
          automaticallyImplyLeading: false),
      body: Obx(
        () => Container(
          padding: const EdgeInsets.only(
              top: 40.0, bottom: 20.0, right: 20.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    color: AppColors.lightGrey3,
                    width: size.width * 0.5,
                    child: Image.asset(
                      data['img_url'] ?? "assets/images/oksimeter.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Center(
                      //   child: Text(
                      //     'Normal',
                      //     textAlign: TextAlign.center,
                      //     style: GoogleFonts.poppins(
                      //         fontSize: 24.0,
                      //         color: AppColors.successColor,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        children: [
                          if (data['hasil_pengukuran'].length > 0)
                            CardHasil(
                                title: data['hasil_pengukuran'][0],
                                value:
                                    hasilPengukuranVM.value1.value.toString(),
                                // satuan: "%",
                                isLoading: hasilPengukuranVM.isLoading.value,
                                valueDitampilkan: hasilPengukuranVM
                                    .valueDitampilkan1.value
                                    .toString()),
                          if (data['hasil_pengukuran'].length > 1)
                            CardHasil(
                                title: data['hasil_pengukuran'][1],
                                value:
                                    hasilPengukuranVM.value2.value.toString(),
                                // satuan: "denyut/menit",
                                isLoading: hasilPengukuranVM.isLoading.value,
                                valueDitampilkan: hasilPengukuranVM
                                    .valueDitampilkan2.value
                                    .toString()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Builder(builder: (context) {
                if (hasilPengukuranVM.isLoading.value == true) {
                  return const Text("");
                }

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        hasilPengukuranVM.value1.value = 0.0;
                        hasilPengukuranVM.value2.value = 0.0;
                        Get.toNamed(Routes.HOME);
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0)),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          )),
                      child: Text(
                        "Selesai",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 20.0),
                      )),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
