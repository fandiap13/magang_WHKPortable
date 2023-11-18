import 'package:get/get.dart';

class SensorService extends GetxController {
  // final RxList<Map<String, dynamic>> dataSensor = <Map<String, dynamic>>[].obs;
  final List<Map> dataSensor = <Map>[].obs;
  final Map dataSensorCoba = {}.obs;

  void clearSensor() {
    dataSensorCoba.clear();
  }

  void setSensor2(data) {
    Map dataBaru = data;
    // filter data yang sama
    // jika data sama maka kita timpa
    dataBaru.forEach((key, value) {
      if (dataSensorCoba[key] != null) {
        dataSensorCoba.remove(key);
      }
    });
    dataSensorCoba.addAll(data);

    // print(dataSensorCoba);
    // dataBaru.addAll(dataSensorCoba);

    // dataSensorCoba.clear();

    // dataSensorCoba.addAll(dataBaru);

    // dataSensorCoba.clear();
    // dataSensorCoba.addAll(dataBaru);

    // Map<String, dynamic> dataGabungan = {...dataBaru, ...dataSensorCoba};
    // print(dataGabungan);

    // dataSensorCoba.addAll({...dataBaru, ...dataSensorCoba});
    // print(dataBaru);
    // print(dataSensorCoba);

    // dataSensorCoba.addAll(hasil);

    // print(dataSensorCoba);
  }
}
