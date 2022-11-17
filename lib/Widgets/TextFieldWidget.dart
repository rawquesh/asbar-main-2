import 'package:asbar/Constants/colors.dart';
import 'package:asbar/Constants/styles.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key, required this.controller, this.isPassword = false})
      : super(key: key);

  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: kGrey),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: kMedium14,
        decoration: const InputDecoration.collapsed(hintText: ""),
      ),
    );
  }
}
