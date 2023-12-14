import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/modules/detail_riwayat_kesehatan/views/widgets/detail_riwayat_kesehatan_card.dart';
import 'package:wish/app/modules/detail_riwayat_kesehatan/views/widgets/grafik_detail_kesehatan.dart';
import 'package:wish/app/modules/detail_riwayat_kesehatan/views/widgets/pagination_widget.dart';
import 'package:wish/app/modules/detail_riwayat_kesehatan/views/widgets/tabel_detail_kesehatan.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/app_bar_component.dart';
import 'package:wish/app/resources/components/my_loader_screen_component.dart';

import '../controllers/detail_riwayat_kesehatan_controller.dart';

class DetailRiwayatKesehatanView extends StatefulWidget {
  const DetailRiwayatKesehatanView({Key? key}) : super(key: key);

  @override
  State<DetailRiwayatKesehatanView> createState() =>
      _DetailRiwayatKesehatanViewState();
}

class _DetailRiwayatKesehatanViewState
    extends State<DetailRiwayatKesehatanView> {
  final detailRiwayatVM = Get.put(DetailRiwayatKesehatanController());
  var data = Get.arguments;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      loadingData();
    });
    super.initState();
  }

  Future<void> loadingData() async {
    await detailRiwayatVM.getDataRiwayatKesehatan(
        data['data_riwayat'], data['type']);
    // detailRiwayatVM.filterRiwayatKesehatan(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(
          title: "${data['title']}",
        ),
        body: Obx(() => detailRiwayatVM.isLoading.value == true
            ? const MyLoaderScreen()
            : SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailRiwayatKesehatanCard(
                        id: data['id'],
                        title: data['title'],
                        icon: data['icon'],
                        tanggal: data['tanggal'],
                        status: data['status'],
                        jam: data['jam'],
                        value1: data['value1'],
                        value2: data['value2'],
                      ),

                      const SizedBox(
                        height: 40.0,
                      ),

                      // Menampilkan Grafik 1
                      if (detailRiwayatVM.dataKesehatan1.isNotEmpty)
                        Column(
                          children: [
                            GrafikDetailKesehatan(
                                title:
                                    "Grafik ${data['title']} (${data['subtitle'][0]})",
                                value: detailRiwayatVM.dataKesehatan1),
                            const SizedBox(
                              height: 20.0,
                            ),
                            PaginationWidget(
                              currentPage: detailRiwayatVM.currentPage.value,
                              pageCount: detailRiwayatVM.totalPage.value,
                              limit: detailRiwayatVM.limit.value,
                              totalItem: detailRiwayatVM.totalItems.value,
                              next: () async {
                                await detailRiwayatVM.nextPage(
                                    data['data_riwayat'], data['type']);
                              },
                              previous: () async {
                                await detailRiwayatVM.previousPage(
                                    data['data_riwayat'], data['type']);
                              },
                            ),
                            // End grafik
                            const SizedBox(
                              height: 40.0,
                            ),
                          ],
                        ),
                      // Menampilkan Grafik 2
                      if (detailRiwayatVM.dataKesehatan2.isNotEmpty)
                        Column(
                          children: [
                            GrafikDetailKesehatan(
                                title:
                                    "Grafik ${data['title']} (${data['subtitle'][1]})",
                                value: detailRiwayatVM.dataKesehatan2),
                            const SizedBox(
                              height: 20.0,
                            ),
                            PaginationWidget(
                              currentPage: detailRiwayatVM.currentPage.value,
                              pageCount: detailRiwayatVM.totalPage.value,
                              limit: detailRiwayatVM.limit.value,
                              totalItem: detailRiwayatVM.totalItems.value,
                              next: () async {
                                await detailRiwayatVM.nextPage(
                                    data['data_riwayat'], data['type']);
                              },
                              previous: () async {
                                await detailRiwayatVM.previousPage(
                                    data['data_riwayat'], data['type']);
                              },
                            ), // End grafik

                            const SizedBox(
                              height: 40.0,
                            ),
                          ],
                        ),

                      Row(
                        children: [
                          Expanded(
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                // title 1
                                if (detailRiwayatVM
                                    .dataRiwayatKesehatan1.isNotEmpty)
                                  Column(
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
                                              Icons.table_chart,
                                              color: AppColors.grey,
                                              size: 20.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            "Tabel ${data['title']} (${data['subtitle'][0]})",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.0,
                                                color:
                                                    AppColors.secondaryColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      TabelDetailKesehatan(
                                        currentPage:
                                            detailRiwayatVM.currentPage.value,
                                        limit: detailRiwayatVM.limit.value,
                                        totalItem:
                                            detailRiwayatVM.totalItems.value,
                                        data: detailRiwayatVM
                                            .dataRiwayatKesehatan1,
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      PaginationWidget(
                                        currentPage:
                                            detailRiwayatVM.currentPage.value,
                                        pageCount:
                                            detailRiwayatVM.totalPage.value,
                                        limit: detailRiwayatVM.limit.value,
                                        totalItem:
                                            detailRiwayatVM.totalItems.value,
                                        next: () async {
                                          await detailRiwayatVM.nextPage(
                                              data['data_riwayat'],
                                              data['type']);
                                        },
                                        previous: () async {
                                          await detailRiwayatVM.previousPage(
                                              data['data_riwayat'],
                                              data['type']);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                    ],
                                  ),

                                /// table 2
                                if (detailRiwayatVM
                                    .dataRiwayatKesehatan2.isNotEmpty)
                                  Column(
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
                                              Icons.table_chart,
                                              color: AppColors.grey,
                                              size: 20.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            "Tabel ${data['title']} (${data['subtitle'][1]})",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.0,
                                                color:
                                                    AppColors.secondaryColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      TabelDetailKesehatan(
                                        currentPage:
                                            detailRiwayatVM.currentPage.value,
                                        limit: detailRiwayatVM.limit.value,
                                        totalItem:
                                            detailRiwayatVM.totalItems.value,
                                        data: detailRiwayatVM
                                            .dataRiwayatKesehatan2,
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      PaginationWidget(
                                        currentPage:
                                            detailRiwayatVM.currentPage.value,
                                        pageCount:
                                            detailRiwayatVM.totalPage.value,
                                        limit: detailRiwayatVM.limit.value,
                                        totalItem:
                                            detailRiwayatVM.totalItems.value,
                                        next: () async {
                                          await detailRiwayatVM.nextPage(
                                              data['data_riwayat'],
                                              data['type']);
                                        },
                                        previous: () async {
                                          await detailRiwayatVM.previousPage(
                                              data['data_riwayat'],
                                              data['type']);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Table
                    ],
                  ),
                ),
              )));
  }
}
