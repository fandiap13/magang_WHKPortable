import 'package:flutter/material.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class DropdownInputWithIcon extends StatefulWidget {
  final List<String> listValue;
  String controller;
  final FocusNode? focusNode;
  final String? hintText;
  final icon;
  final Color? bgColor;
  final textColor;
  final changeValue;
  final validator;
  final String? errorText;

  DropdownInputWithIcon(
      {super.key,
      required this.listValue,
      this.controller = "",
      this.focusNode,
      this.hintText,
      this.icon,
      this.bgColor,
      required this.changeValue,
      required this.validator,
      this.errorText,
      this.textColor = AppColors.primaryColor});

  @override
  State<DropdownInputWithIcon> createState() => _DropdownInputWithIconState();
}

class _DropdownInputWithIconState extends State<DropdownInputWithIcon> {
  bool obsecureText = true;

  Color _iconColor = Colors.grey; // initial color

  @override
  void initState() {
    super.initState();
    widget.focusNode!.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _iconColor =
          widget.focusNode!.hasFocus ? AppColors.primaryColor : Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          focusNode: widget.focusNode,
          validator: widget.validator,
          value: widget.controller, // Nilai yang dipilih
          onChanged: widget.changeValue,
          items: widget.listValue.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
          icon: Icon(
            Icons.arrow_drop_down,
            color: _iconColor,
          ), // Mengubah ikon dropdown
          iconSize: 24.0, // Mengubah ukuran ikon dropdown
          isExpanded:
              true, // Membuat tombol dropdown mengisi lebar yang tersedia
          decoration: InputDecoration(
            errorText: widget.errorText,
            prefixIcon: Icon(
              widget.icon,
              color: _iconColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.textColor),
            ),
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
