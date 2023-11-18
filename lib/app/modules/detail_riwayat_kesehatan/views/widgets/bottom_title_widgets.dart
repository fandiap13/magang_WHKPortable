import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wish/app/modules/detail_riwayat_kesehatan/controllers/detail_riwayat_kesehatan_controller.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  final detailRiwayatVM = Get.put(DetailRiwayatKesehatanController());

  Widget text;

  int index = value.toInt();

  text = Column(
    children: [
      Expanded(
        child: Text(
          DateFormat('dd MMM y').format(DateTime.parse(
            detailRiwayatVM.tanggal[index].toString(),
          )),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
