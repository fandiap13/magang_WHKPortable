import 'package:get/get.dart';

import '../controllers/kirim_ulasan_controller.dart';

class KirimUlasanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KirimUlasanController>(
      () => KirimUlasanController(),
    );
  }
}
