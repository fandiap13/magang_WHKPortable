import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/device_icon_component.dart';

class DetailRiwayatKesehatanCard extends StatelessWidget {
  final int id;
  final String title;
  final IconData icon;
  final String tanggal;
  final String status;
  final String jam;
  final Map<String, dynamic> value1;
  final Map<String, dynamic>? value2;

  const DetailRiwayatKesehatanCard(
      {super.key,
      required this.id,
      required this.title,
      required this.icon,
      required this.tanggal,
      required this.status,
      required this.jam,
      required this.value1,
      this.value2});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeviceIconComponent(icon: icon, title: title),
            const SizedBox(
              height: 10.0,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Pengukuran Terakhir",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: AppColors.secondaryColor)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tanggal,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                          color: AppColors.secondaryColor)),
                  Text(jam,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                          color: AppColors.grey))
                ],
              )
            ]),
            const SizedBox(
              height: 20.0,
            ),
            Text(StringUtils.capitalize(status),
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: status.toLowerCase() == 'normal'
                        ? AppColors.green
                        : AppColors.dangerColor)),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value1['title'],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                            color: AppColors.grey)),
                    Row(
                      children: [
                        Text("${value1['value']} ",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 25.0,
                                color: AppColors.secondaryColor)),
                        Text(value1['satuan'],
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: AppColors.secondaryColor)),
                      ],
                    )
                  ],
                ),
                Builder(builder: (context) {
                  if (value2.isNull) {
                    return const Text("");
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(value2!['title'],
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              color: AppColors.grey)),
                      Row(
                        children: [
                          Text("${value2!['value']} ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25.0,
                                  color: AppColors.secondaryColor)),
                          Text(value2!['satuan'],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: AppColors.secondaryColor)),
                        ],
                      )
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
