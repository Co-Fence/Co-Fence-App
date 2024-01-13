import 'package:co_fence/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyElevatedButton extends StatelessWidget {
  // 라우팅할 주소가 있다면 url을, 없다면 onPressed를 사용한다.
  final String? url;
  final Color? backgroundColor;
  final String buttonText;
  final VoidCallback? onPressed;
  final Color textColor;

  const MyElevatedButton({
    super.key,
    this.url,
    this.backgroundColor = PRIMARY_COLOR,
    required this.buttonText,
    this.onPressed,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (url != null) {
          context.go(url!);
        } else if (onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(
          width: 2,
          color: PRIMARY_COLOR,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
        ),
      ),
    );
  }
}
