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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: primaryColor,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
        ),
        child: TextField(
          autofocus: autofocus,
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                onPressed: onPressed),
          ),
        ),
      ),
    );
  }
}
