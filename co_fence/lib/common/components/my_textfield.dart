import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final controller;
  final validator;
  final String hintText;
  final bool obscureText;
  const MyTextFormField({
    super.key,
    this.controller,
    this.validator,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
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
