import 'package:get/get.dart';

import '../controllers/hasil_pengukuran_controller.dart';

class HasilPengukuranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HasilPengukuranController>(
      () => HasilPengukuranController(),
    );
  }
}
