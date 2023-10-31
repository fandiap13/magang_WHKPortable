import 'package:flutter/material.dart';
import 'package:wish/app/modules/connect_device/views/widgets/header_connect_device_widget.dart';
import 'package:wish/app/modules/connect_device/views/widgets/text_format.dart';

class BeratBadan extends StatelessWidget {
  const BeratBadan({
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
              "Hidupkan Bluetooth untuk menyambungkan aplikasi dengan timbangan.",
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
          text: "Naik ke atas timbangan.",
        ),
        Center(
          child: SizedBox(
            width: 140,
            height: 140,
            child:
                Image.asset("assets/images/berat_badan.png", fit: BoxFit.cover),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        const TextFormat(
          number: "3",
          text:
              'Tekan tombol "Pindai Perangkat" pada aplikasi untuk mendeteksi timbangan.',
        ),
        const TextFormat(
          number: "4",
          text:
              'Jika sudah tekan tombol "Hubungkan Ke Perangkat" untuk menyambungkan ke timbangan. ',
        ),
        const SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
