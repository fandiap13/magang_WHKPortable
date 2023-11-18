import 'package:flutter/material.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class LabelCheckPenggunaanDevice extends StatelessWidget {
  final String deviceName;
  final String? result;
  final String? tanggal;
  final bool checked;

  const LabelCheckPenggunaanDevice({
    super.key,
    required this.deviceName,
    required this.checked,
    this.result,
    this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      leading: Icon(
        checked == true
            ? Icons.check_box_outlined
            : Icons.check_box_outline_blank,
        color: checked == true ? AppColors.successColor : AppColors.dangerColor,
      ),
      title: Text(
        deviceName,
        style: const TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tanggal != null)
            Text(
              "$tanggal",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          Text(
            result == null ? "Belum melakukan pengukuran" : "$result",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
