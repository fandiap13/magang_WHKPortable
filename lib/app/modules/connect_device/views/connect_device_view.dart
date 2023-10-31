import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wish/app/modules/connect_device/views/widgets/berat_badan_widget.dart';
import 'package:wish/app/modules/connect_device/views/widgets/oksimeter_widget.dart';
import 'package:wish/app/modules/connect_device/views/widgets/termometer.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/app_bar_component.dart';

import '../controllers/connect_device_controller.dart';

class ConnectDeviceView extends StatefulWidget {
  const ConnectDeviceView({Key? key}) : super(key: key);

  @override
  State<ConnectDeviceView> createState() => _ConnectDeviceViewState();
}

class _ConnectDeviceViewState extends State<ConnectDeviceView> {
  final connectDeviceVM = Get.put(ConnectDeviceController());
  bool isInitialized = false;
  var dataArgument = Get.arguments;

  @override
  void initState() {
    // Future.delayed(Duration.zero, () {
    //   pindaiPerangkat();
    // });
    super.initState();
  }

  Future<void> pindaiPerangkat() async {
    // cari perangkat berdasarkan id
    await connectDeviceVM.searchDevice(dataArgument);
    // print(dataArgument);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarComponent(title: dataArgument['nama']),
      body: Container(
        padding: const EdgeInsets.only(
            top: 40.0, bottom: 20.0, right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  color: Colors.transparent,
                  width: size.width * 0.5,
                  child: Image.asset(
                    dataArgument['img_url'] ?? "assets/images/oksimeter.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Builder(builder: (context) {
                  if (dataArgument['nama'].toLowerCase() == "oksimeter") {
                    return const OksimeterWidget();
                  } else if (dataArgument['nama'].toLowerCase() ==
                      "berat badan") {
                    return const BeratBadan();
                  } else {
                    return const Termometer();
                  }
                }),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (connectDeviceVM.connectedDevice.value != null)
                      ElevatedButton(
                        onPressed: () async {
                          if (connectDeviceVM.isConnecting.value == false) {
                            await connectDeviceVM.connectToDevice(
                                dataArgument['characteristicID'],
                                dataArgument['nama'],
                                dataArgument['img_url'],
                                dataArgument['hasil_pengukuran']);
                          }
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0)),
                            backgroundColor: MaterialStateProperty.all(
                                connectDeviceVM.isConnecting.value == false
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor.withOpacity(0.4)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            )),
                        child: Builder(builder: (context) {
                          if (connectDeviceVM.isConnecting.value == true) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sedang menghubungkan",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                          color: Colors.white, size: 25.0),
                                ),
                              ],
                            );
                          }
                          return Text(
                            "Hubungkan Ke Perangkat",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 20.0),
                          );
                        }),
                      ),

                    // ini adalah ketika anda belum ada device yang terkoneksi
                    if (connectDeviceVM.connectedDevice.value == null)
                      ElevatedButton(
                        onPressed: () async {
                          // print("pencet to");
                          if (connectDeviceVM.isScanning.value == false) {
                            await connectDeviceVM.searchDevice(dataArgument);
                          }
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0)),
                            backgroundColor: MaterialStateProperty.all(
                                connectDeviceVM.isScanning.value == false
                                    ? AppColors.lightDark
                                    : AppColors.lightDark.withOpacity(0.4)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            )),
                        child: Builder(builder: (context) {
                          if (connectDeviceVM.isScanning.value == true) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Loading",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                          color: Colors.white, size: 25.0),
                                ),
                              ],
                            );
                          }

                          return Text(
                            "Pindai Perangkat",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 20.0),
                          );
                        }),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
