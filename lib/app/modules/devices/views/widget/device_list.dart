import 'package:flutter/material.dart';
import 'package:wish/app/modules/devices/controllers/device_controller.dart';
import 'package:wish/app/modules/devices/views/widget/device_card.dart';
import 'package:wish/app/modules/devices/views/widget/modal_device.dart';

class DeviceList extends StatelessWidget {
  const DeviceList({
    super.key,
    required this.deviceVM,
  });

  final DeviceController deviceVM;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: deviceVM.listDevice.length,
        itemBuilder: (context, index) {
          return DeviceCard(
            imageUrl: deviceVM.listDevice[index]['img_url'] ??
                "assets/images/oksimeter.png",
            title: deviceVM.listDevice[index]['nama'],
            icon: Icons.info_outline,
            onTapFunction: () {
              showModalDevice(context, deviceVM.listDevice[index]);
            },
            duration: (600 + (index * 100)),
          );
        });
  }
}
