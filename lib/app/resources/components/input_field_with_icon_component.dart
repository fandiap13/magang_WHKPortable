import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';

class InputFieldWithIconComponent extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final validator;
  final onFiledSubmitted;
  final VoidCallback? onTap;
  final bool? isPasswordField;
  final bool? readOnlyStatus;
  final String? hintText;
  final IconData? icon;
  final inputType;
  final Color? bgColor;
  final Color textColor;
  final String? errorText;

  final double? width;
  final double? height;

  const InputFieldWithIconComponent(
      {super.key,
      this.controller,
      this.focusNode,
      required this.validator,
      this.onFiledSubmitted,
      this.isPasswordField,
      this.readOnlyStatus,
      this.hintText,
      this.icon,
      this.onTap,
      this.inputType,
      this.bgColor,
      this.width,
      this.height,
      this.errorText,
      this.textColor = AppColors.primaryColor});

  @override
  State<InputFieldWithIconComponent> createState() =>
      _InputFieldWithIconComponentState();
}

class _InputFieldWithIconComponentState
    extends State<InputFieldWithIconComponent> {
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
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(10.0)),
      child: TextFormField(
        readOnly: widget.readOnlyStatus == true ? obsecureText : false,
        focusNode: widget.focusNode,
        keyboardType: widget.inputType,
        controller: widget.controller,
        validator: widget.validator,
        onFieldSubmitted: widget.onFiledSubmitted,
        obscureText: widget.isPasswordField == true ? obsecureText : false,
        style: const TextStyle(fontSize: 16),
        onTap: widget.onTap,
        decoration: InputDecoration(
          errorText: widget.errorText,
          errorMaxLines: 10,
          label: Text(
            widget.hintText.toString(),
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          prefixIcon: widget.icon == null
              ? const Text("")
              : Icon(
                  widget.icon,
                  color: _iconColor,
                ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obsecureText = !obsecureText;
              });
            },
            child: widget.isPasswordField == true
                ? Icon(
                    obsecureText == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: _iconColor,
                  )
                : const Text(""),
          ),
          hintText: widget.hintText,
          // Set border color pada OutlineInputBorder
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: widget.textColor), // Warna border saat focused
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.transparent), // Warna border saat tidak focused
          ),
        ),
      ),
    );
  }
}
