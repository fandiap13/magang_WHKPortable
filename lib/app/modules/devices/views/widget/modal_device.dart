import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/modules/devices/controllers/device_controller.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/utils/app_utils.dart';

final deviceVM = Get.put(DeviceController());

showModalDevice(BuildContext context, dynamic dataDevice) {
  Widget content = Column(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    dataDevice['nama'],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: AppColors.secondaryColor),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        dataDevice['img_url'] ?? "assets/images/oksimeter.png",
                        fit: BoxFit.contain,
                      )),
                ),
                Text(
                  dataDevice['description'] ?? "kosong",
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      color: AppColors.lightDark,
                      fontSize: 16.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Hasil Pengukuran :",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: AppColors.secondaryColor),
                ),
                Builder(builder: (context) {
                  if (dataDevice['hasil_pengukuran'] == null) {
                    return const Text("Kosong");
                  }

                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataDevice['hasil_pengukuran'].length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            leading: const Icon(
                              Icons.circle,
                              size: 15.0,
                            ),
                            title: Text(
                              dataDevice['hasil_pengukuran'][index],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 15.0,
                )
              ],
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        color: AppColors.lightGrey3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0)),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.dangerColor)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Batal",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 18.0),
                  )),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0)),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor)),
                  onPressed: () async {
                    if (dataDevice['deviceID'] != null &&
                        dataDevice['characteristicID'] != null) {
                      // menutup modal
                      await deviceVM.checkBluetoothIsOn(
                          context,
                          dataDevice['deviceID'],
                          dataDevice['characteristicID'],
                          dataDevice['nama'],
                          dataDevice['img_url'],
                          dataDevice['hasil_pengukuran']);
                    } else {
                      AppUtils.toast(
                          "Device ID kosong !", AppColors.dangerColor);
                    }
                  },
                  child: Text(
                    "Mulai Pengukuran",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 18.0),
                  )),
            ),
          ],
        ),
      )
    ],
  );

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return content;
    },
  );
}
