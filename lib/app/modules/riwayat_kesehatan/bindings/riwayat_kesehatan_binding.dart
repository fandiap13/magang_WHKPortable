import 'package:get/get.dart';

import '../controllers/riwayat_kesehatan_controller.dart';

class RiwayatKesehatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatKesehatanController>(
      () => RiwayatKesehatanController(),
    );
  }
}
