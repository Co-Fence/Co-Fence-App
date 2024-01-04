import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool readOnly;
  final dynamic validator;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  const MyTextFormField({
    super.key,
    this.controller,
    this.validator,
    required this.hintText,
    required this.obscureText,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
