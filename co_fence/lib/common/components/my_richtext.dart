import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  final String text1;
  final String? text2;
  final bool isRequired;
  const MyRichText({
    super.key,
    required this.text1,
    this.text2,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: text2,
            style: isRequired
                ? const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )
                : const TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
          ),
        ],
      ),
    );
  }
}
