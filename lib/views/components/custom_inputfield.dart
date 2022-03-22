import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({required this.controller, this.hint,required this.maxLines, Key? key})
      : super(key: key);
  TextEditingController controller;
  int maxLines;
  String? hint;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(hintText: hint)));
  }
}
