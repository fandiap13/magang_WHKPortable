import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/modules/detail_riwayat_kesehatan/controllers/detail_riwayat_kesehatan_controller.dart';
import 'package:wish/app/modules/detail_riwayat_kesehatan/views/widgets/bottom_title_widgets.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class GrafikDetailKesehatan extends StatefulWidget {
  final value;
  final String title;

  const GrafikDetailKesehatan(
      {super.key, required this.value, required this.title});

  @override
  State<GrafikDetailKesehatan> createState() => _GrafikDetailKesehatanState();
}

class _GrafikDetailKesehatanState extends State<GrafikDetailKesehatan> {
  final detailRiwayatVM = Get.put(DetailRiwayatKesehatanController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightGrey3,
              ),
              child: const Icon(
                Icons.area_chart,
                color: AppColors.grey,
                size: 20.0,
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: AppColors.secondaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Obx(
          () => Center(
            child: Container(
              // color: Colors.red,
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.only(right: 30.0),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ))),
                  borderData: FlBorderData(
                      show: false,
                      border:
                          Border.all(color: AppColors.primaryColor, width: 1)),
                  lineBarsData: [
                    LineChartBarData(
                      dotData: const FlDotData(
                        show: true,
                      ),
                      spots: widget.value,
                      isCurved: false,
                      color: AppColors.lightDark,
                      belowBarData: BarAreaData(
                          show: true,
                          color: AppColors.lightBlue.withOpacity(0.4)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
