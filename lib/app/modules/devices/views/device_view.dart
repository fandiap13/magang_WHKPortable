import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wish/app/modules/devices/controllers/device_controller.dart';
import 'package:wish/app/modules/devices/views/widget/device_list.dart';
import 'package:wish/app/modules/devices/views/widget/label_check_penggunaan_device.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/app_bar_component.dart';
import 'package:wish/app/resources/components/header_text.dart';
import 'package:wish/app/services/sensor_service.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({Key? key}) : super(key: key);

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> with TickerProviderStateMixin {
  final deviceVM = Get.put(DeviceController());
  final sensorService = Get.put(SensorService());

  AnimationController? _fadeInController;
  AnimationController? _slideController;
  Animation<double>? _animationFadeIn;
  Animation<Offset>? _slideAnimation;

  bool _show = true;

  @override
  void initState() {
    super.initState();

    _fadeInController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800 * 2));
    _slideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    _animationFadeIn =
        Tween<double>(begin: 0, end: 1).animate(_fadeInController!);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start off the screen (top)
      end: const Offset(0, 0), // End position (center of the screen)
    ).animate(CurvedAnimation(
      parent: _slideController!,
      curve: Curves.easeInOut,
    ));

    _slideController!.forward();
    _fadeInController!.forward();
  }

  @override
  void dispose() {
    _slideController!.dispose();
    _fadeInController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarComponent(
          title: "Cek Kesehatan",
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HeaderText(
                            headerText1: "Daftar Perangkat Kesehatan",
                            headerText2:
                                "Perangkat yang tersedia untuk pengecekan kesehatan.",
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),

                          // DEVICE CHECKED
                          SlideTransition(
                            position: _slideAnimation!,
                            child: FadeTransition(
                              opacity: _animationFadeIn!,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Pengecekan saat ini : ",
                                            style: TextStyle(
                                                color: AppColors.secondaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _show = !_show;
                                                });
                                              },
                                              child: Icon(_show == true
                                                  ? Icons.remove
                                                  : Icons.add))
                                        ],
                                      ),

                                      // perlihatkan isinya
                                      if (_show == true)
                                        // obxnya ditaruh di paling atas biar work
                                        Obx(
                                          () => Column(
                                            children: [
                                              const Divider(),
                                              Builder(builder: (context) {
                                                return Text(
                                                  "Ini adalah data pengecekan anda, silahkan dilengkapi lalu disimpan...",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .secondaryColor,
                                                      fontSize: 15.0),
                                                );
                                              }),
                                              const SizedBox(
                                                height: 10.0,
                                              ),

                                              // pengulangan device yang tersedia
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    deviceVM.listDevice.length,
                                                itemBuilder: (context, index) {
                                                  return Builder(
                                                    builder: (context) {
                                                      bool checked = false;
                                                      String result = "";
                                                      String? tanggal;

                                                      // Filter data
                                                      List key = [];
                                                      if (deviceVM
                                                              .listDevice[index]
                                                                  ['nama']
                                                              .toLowerCase() ==
                                                          'oksimeter') {
                                                        key = [
                                                          'blood_oxygen',
                                                          'heart_rate'
                                                        ];
                                                      } else if (deviceVM
                                                              .listDevice[index]
                                                                  ['nama']
                                                              .toLowerCase() ==
                                                          'berat badan') {
                                                        key = [
                                                          'body_weight',
                                                          'body_mass_index'
                                                        ];
                                                      } else if (deviceVM
                                                              .listDevice[index]
                                                                  ['nama']
                                                              .toLowerCase() ==
                                                          'termometer') {
                                                        key = [
                                                          'body_temperature',
                                                        ];
                                                      } else if (deviceVM
                                                              .listDevice[index]
                                                                  ['nama']
                                                              .toLowerCase() ==
                                                          'tekanan darah') {
                                                        key = [
                                                          'blood_pressure',
                                                        ];
                                                      }

                                                      // Filter data
                                                      var filteredData = [];
                                                      for (String key in key) {
                                                        if (sensorService
                                                                .dataSensorCoba
                                                                .containsKey(
                                                                    key) &&
                                                            sensorService
                                                                        .dataSensorCoba[
                                                                    key] !=
                                                                null) {
                                                          filteredData.add(key);
                                                        }
                                                      }

                                                      /// jika data yang difilter sama dengan data key
                                                      if (filteredData.length ==
                                                          key.length) {
                                                        filteredData
                                                            .asMap()
                                                            .forEach((i, data) {
                                                          // jika value pengukuran sensor dalam bentuk 90/80 atau bentuk pecahan maka dipecah
                                                          if (sensorService
                                                                  .dataSensorCoba[
                                                                      data]![0]
                                                                      ['value']
                                                                  .toString()
                                                                  .split("/")
                                                                  .length >
                                                              1) {
                                                            int i2 = 0;
                                                            for (var value
                                                                in sensorService
                                                                    .dataSensorCoba[
                                                                        data]![
                                                                        0][
                                                                        'value']
                                                                    .toString()
                                                                    .split(
                                                                        "/")) {
                                                              if (i2 ==
                                                                  (sensorService
                                                                          .dataSensorCoba[
                                                                              data]![
                                                                              0]
                                                                              [
                                                                              'value']
                                                                          .toString()
                                                                          .split(
                                                                              "/")
                                                                          .length -
                                                                      1)) {
                                                                result +=
                                                                    " ${deviceVM.listDevice[index]['hasil_pengukuran'][i2]}: $value.";
                                                              } else {
                                                                result +=
                                                                    "${deviceVM.listDevice[index]['hasil_pengukuran'][i2]}: $value, ";
                                                              }
                                                              i2++;
                                                            }
                                                            // jika value pengukuran sensor dalam bentuk normal
                                                          } else {
                                                            // jika data terakhir
                                                            if (i ==
                                                                (filteredData
                                                                        .length -
                                                                    1)) {
                                                              result +=
                                                                  "${deviceVM.listDevice[index]['hasil_pengukuran'][i]}: ${sensorService.dataSensorCoba[data]![0]['value']}.";
                                                            } else {
                                                              result +=
                                                                  "${deviceVM.listDevice[index]['hasil_pengukuran'][i]}: ${sensorService.dataSensorCoba[data]![0]['value']}, ";
                                                            }
                                                          }
                                                        });

                                                        initializeDateFormatting(
                                                            'id', null);
                                                        tanggal = DateFormat(
                                                                'EEEE, dd MMM y HH:mm:ss',
                                                                'id')
                                                            .format(DateTime.parse(
                                                                sensorService
                                                                    .dataSensorCoba[
                                                                        key[0]]![
                                                                        0][
                                                                        'start_at']
                                                                    .toString()));
                                                        checked = true;
                                                      } else {
                                                        result =
                                                            "Belum melakukan pengukuran";
                                                      }
                                                      return LabelCheckPenggunaanDevice(
                                                        checked: checked,
                                                        deviceName:
                                                            deviceVM.listDevice[
                                                                index]['nama'],
                                                        tanggal: tanggal,
                                                        result: result,
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              // if (sensorService
                                              //     .dataSensor.isNotEmpty)
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (deviceVM.isLoading
                                                              .value ==
                                                          false) {
                                                        await deviceVM
                                                            .savePengecekan(
                                                                context);
                                                      }
                                                    },
                                                    style: ButtonStyle(
                                                        padding: MaterialStateProperty.all(
                                                            const EdgeInsets.symmetric(
                                                                vertical: 10.0,
                                                                horizontal:
                                                                    10.0)),
                                                        backgroundColor: deviceVM.isLoading.value == false
                                                            ? MaterialStateProperty.all(
                                                                AppColors
                                                                    .primaryColor)
                                                            : MaterialStateProperty.all(
                                                                AppColors.primaryColor
                                                                    .withOpacity(
                                                                        0.5)),
                                                        shape: MaterialStateProperty
                                                            .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        )),
                                                    child: deviceVM.isLoading.value ==
                                                            false
                                                        ? const Text(
                                                            "Simpan",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        : LoadingAnimationWidget.staggeredDotsWave(
                                                            color: Colors.white,
                                                            size: 25.0)),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          // DEVICE CHECKED END
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    // DEVICE LIST
                    DeviceList(deviceVM: deviceVM)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
