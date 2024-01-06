import 'package:co_fence/common/const/colors.dart';
import 'package:flutter/material.dart';

class MySearchTextField extends StatelessWidget {
  final bool autofocus;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final Color primaryColor;
  final VoidCallback? onPressed;

  const MySearchTextField({
    super.key,
    this.autofocus = true,
    required this.focusNode,
    required this.controller,
    this.hintText = 'Search',
    this.primaryColor = PRIMARY_COLOR,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: primaryColor,
            ),
            onPressed: onPressed),
      ),
    );
  }
}
