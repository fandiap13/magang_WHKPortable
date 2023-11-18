// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:wish/app/modules/devices/controllers/device_controller.dart';
// import 'package:wish/app/modules/devices/views/widget/device_card.dart';
// import 'package:wish/app/modules/devices/views/widget/label_check_penggunaan_device.dart';
// import 'package:wish/app/modules/devices/views/widget/modal_device.dart';
// import 'package:wish/app/resources/colors/app_colors.dart';
// import 'package:wish/app/resources/components/app_bar_component.dart';
// import 'package:wish/app/resources/components/header_text.dart';
// import 'package:wish/app/resources/utils/app_utils.dart';
// import 'package:wish/app/services/sensor_service.dart';

// class DeviceView extends StatefulWidget {
//   const DeviceView({Key? key}) : super(key: key);

//   @override
//   State<DeviceView> createState() => _DeviceViewState();
// }

// class _DeviceViewState extends State<DeviceView> with TickerProviderStateMixin {
//   final deviceVM = Get.put(DeviceController());
//   final sensorService = Get.put(SensorService());

//   AnimationController? _fadeInController;
//   AnimationController? _slideController;
//   Animation<double>? _animationFadeIn;
//   Animation<Offset>? _slideAnimation;

//   bool _show = true;

//   @override
//   void initState() {
//     super.initState();

//     _fadeInController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 800 * 2));
//     _slideController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 800));

//     _animationFadeIn =
//         Tween<double>(begin: 0, end: 1).animate(_fadeInController!);
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, -1), // Start off the screen (top)
//       end: const Offset(0, 0), // End position (center of the screen)
//     ).animate(CurvedAnimation(
//       parent: _slideController!,
//       curve: Curves.easeInOut,
//     ));

//     _slideController!.forward();
//     _fadeInController!.forward();
//   }

//   @override
//   void dispose() {
//     _slideController!.dispose();
//     _fadeInController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const AppBarComponent(
//           title: "Cek Kesehatan",
//           automaticallyImplyLeading: false,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 15.0, vertical: 30.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const HeaderText(
//                             headerText1: "Daftar Perangkat Kesehatan",
//                             headerText2:
//                                 "Perangkat yang tersedia untuk pengecekan kesehatan.",
//                           ),
//                           const SizedBox(
//                             height: 20.0,
//                           ),

//                           // DEVICE CHECKED
//                           SlideTransition(
//                             position: _slideAnimation!,
//                             child: FadeTransition(
//                               opacity: _animationFadeIn!,
//                               child: Card(
//                                 elevation: 2,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 15.0, horizontal: 20.0),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           const Text(
//                                             "Pengecekan saat ini : ",
//                                             style: TextStyle(
//                                                 color: AppColors.secondaryColor,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16.0),
//                                           ),
//                                           GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _show = !_show;
//                                                 });
//                                               },
//                                               child: Icon(_show == true
//                                                   ? Icons.remove
//                                                   : Icons.add))
//                                         ],
//                                       ),

//                                       // perlihatkan isinya
//                                       if (_show == true)
//                                         Column(
//                                           children: [
//                                             const Divider(),
//                                             Builder(builder: (context) {
//                                               int jmlSensor =
//                                                   deviceVM.listDevice.length;
//                                               int jmlDataSensor = sensorService
//                                                   .dataSensor.length;
//                                               String text = "";
//                                               if ((jmlSensor - jmlDataSensor) <
//                                                       1 &&
//                                                   (jmlSensor - jmlDataSensor) >
//                                                       0) {
//                                                 text =
//                                                     "Anda sudah melakukan semua pemeriksaan silahkan simpan data Anda.";
//                                               } else if (jmlDataSensor == 0) {
//                                                 text =
//                                                     "Anda belum melakukan pemeriksaan sama sekali.";
//                                               } else {
//                                                 text =
//                                                     "Anda baru melakukan $jmlDataSensor pemeriksaan Lakukan ${jmlSensor - jmlDataSensor} pemeriksaan lagi.";
//                                               }
//                                               return Text(
//                                                 text,
//                                                 style: GoogleFonts.poppins(
//                                                     fontWeight: FontWeight.w500,
//                                                     color: AppColors
//                                                         .secondaryColor,
//                                                     fontSize: 15.0),
//                                               );
//                                             }),
//                                             const SizedBox(
//                                               height: 10.0,
//                                             ),
//                                             ListView.builder(
//                                               physics:
//                                                   const NeverScrollableScrollPhysics(),
//                                               shrinkWrap: true,
//                                               itemCount:
//                                                   deviceVM.listDevice.length,
//                                               itemBuilder: (context, index) {
//                                                 return Builder(
//                                                     builder: (context) {
//                                                   bool checked = false;
//                                                   String result = "";
//                                                   String? tanggal;
//                                                   var filteredData = sensorService
//                                                       .dataSensor
//                                                       .where((person) =>
//                                                           person['nama']
//                                                               .toString()
//                                                               .toLowerCase() ==
//                                                           deviceVM
//                                                               .listDevice[index]
//                                                                   ['nama']
//                                                               .toString()
//                                                               .toLowerCase())
//                                                       .toList();

//                                                   // print(filteredData);

//                                                   if (filteredData.isNotEmpty) {
//                                                     var data = filteredData[0][
//                                                         'data_hasil_pengukuran'];
//                                                     if (data != null) {
//                                                       for (int i = 0;
//                                                           i < data.length;
//                                                           i++) {
//                                                         if (i ==
//                                                             (data.length - 1)) {
//                                                           result +=
//                                                               " ${data[i]['value']} ${data[i]['satuan']}.";
//                                                         } else {
//                                                           result +=
//                                                               "${data[i]['value']} ${data[i]['satuan']}, ";
//                                                         }
//                                                       }
//                                                     }

//                                                     initializeDateFormatting(
//                                                         'id', null);
//                                                     tanggal = DateFormat(
//                                                             'EEEE, dd MMM y HH:mm:ss',
//                                                             'id')
//                                                         .format(DateTime.parse(
//                                                             filteredData[0]
//                                                                 ['tanggal']));
//                                                     checked = true;
//                                                   } else {
//                                                     result =
//                                                         "Belum melakukan pengukuran";
//                                                   }
//                                                   return LabelCheckPenggunaanDevice(
//                                                     checked: checked,
//                                                     deviceName: deviceVM
//                                                             .listDevice[index]
//                                                         ['nama'],
//                                                     tanggal: tanggal,
//                                                     result: result,
//                                                   );
//                                                 });
//                                               },
//                                             ),
//                                             const SizedBox(
//                                               height: 10.0,
//                                             ),
//                                             // if (sensorService
//                                             //     .dataSensor.isNotEmpty)
//                                             if (sensorService
//                                                 .dataSensorCoba.isNotEmpty)
//                                               SizedBox(
//                                                 width: double.infinity,
//                                                 child: Obx(
//                                                   () => ElevatedButton(
//                                                       onPressed: () async {
//                                                         if (deviceVM.isLoading
//                                                                 .value ==
//                                                             false) {
//                                                           await deviceVM
//                                                               .savePengecekan(
//                                                                   context);
//                                                         }
//                                                       },
//                                                       style: ButtonStyle(
//                                                           padding: MaterialStateProperty.all(
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   vertical:
//                                                                       10.0,
//                                                                   horizontal:
//                                                                       10.0)),
//                                                           backgroundColor: deviceVM
//                                                                       .isLoading
//                                                                       .value ==
//                                                                   false
//                                                               ? MaterialStateProperty.all(
//                                                                   AppColors
//                                                                       .primaryColor)
//                                                               : MaterialStateProperty.all(
//                                                                   AppColors
//                                                                       .primaryColor
//                                                                       .withOpacity(
//                                                                           0.5)),
//                                                           shape:
//                                                               MaterialStateProperty.all(
//                                                             RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.0),
//                                                             ),
//                                                           )),
//                                                       child: deviceVM.isLoading.value == false
//                                                           ? const Text(
//                                                               "Simpan",
//                                                               style: TextStyle(
//                                                                   fontSize: 16),
//                                                             )
//                                                           : LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 25.0)),
//                                                 ),
//                                               )
//                                           ],
//                                         )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                           // DEVICE CHECKED END
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10.0,
//                     ),

//                     // DEVICE LIST
//                     ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         padding: const EdgeInsets.all(10.0),
//                         itemCount: deviceVM.listDevice.length,
//                         itemBuilder: (context, index) {
//                           return DeviceCard(
//                             imageUrl: deviceVM.listDevice[index]['img_url'] ??
//                                 "assets/images/oksimeter.png",
//                             title: deviceVM.listDevice[index]['nama'],
//                             icon: Icons.info_outline,
//                             onTapFunction: () {
//                               showModalDevice(
//                                   context, deviceVM.listDevice[index]);
//                             },
//                             duration: (600 + (index * 100)),
//                           );
//                         })
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
