import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final int? maxLine;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        maxLines: maxLine,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          hintText: hintText,
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.9),
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
