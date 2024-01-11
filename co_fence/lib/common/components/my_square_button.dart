import 'package:co_fence/common/const/colors.dart';
import 'package:flutter/material.dart';

class MySquareButton extends StatelessWidget {
  final Function() onTap;
  final IconData? icon;
  final String? label;
  final double width;
  final double height;
  final Color color;
  const MySquareButton({
    super.key,
    required this.onTap,
    this.width = 100.0,
    this.height = 100.0,
    this.label,
    this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          16,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: SECONDARY_COLOR,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 50,
                  color: SECONDARY_COLOR,
                ),
              if (label != null)
                Text(
                  label!,
                  style: const TextStyle(
                    fontSize: 20,
                    color: SECONDARY_COLOR,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
