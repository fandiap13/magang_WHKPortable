import 'package:flutter/material.dart';
import 'package:wish/app/modules/connect_device/views/widgets/header_connect_device_widget.dart';
import 'package:wish/app/modules/connect_device/views/widgets/text_format.dart';

class OksimeterWidget extends StatelessWidget {
  const OksimeterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        const HeaderConnectDevice(),
        const TextFormat(
          number: "1",
          text:
              "Hidupkan Bluetooth untuk menyambungkan aplikasi dengan oksimeter.",
        ),
        Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child:
                Image.asset("assets/images/tutorial_1.png", fit: BoxFit.cover),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        const TextFormat(
          number: "2",
          text:
              "Tempatkan pulse oksimeter pada jari telunjuk atau jari tengah Anda dan pastikan jari Anda bersih dan kering.",
        ),
        const TextFormat(
          number: "3",
          text:
              'Tekan tombol "Power" pada perangkat oksimeter untuk mengaktifkan pulse oksimeter.',
        ),
        Center(
          child: SizedBox(
            width: 140,
            height: 140,
            child: Image.asset("assets/images/oksimeter_tutorial_1.png",
                fit: BoxFit.cover),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        const TextFormat(
          number: "4",
          text:
              'Tekan tombol "Pindai Perangkat" pada aplikasi untuk mendeteksi oksimeter.',
        ),
        const TextFormat(
          number: "5",
          text:
              'Jika sudah tekan tombol "Hubungkan Ke Perangkat" untuk menyambungkan ke oksimeter. ',
        ),
        const SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
