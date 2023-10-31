import 'package:get/get.dart';

import '../controllers/detail_riwayat_kesehatan_controller.dart';

class DetailRiwayatKesehatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailRiwayatKesehatanController>(
      () => DetailRiwayatKesehatanController(),
    );
  }
}
