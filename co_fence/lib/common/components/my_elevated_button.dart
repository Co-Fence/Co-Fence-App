import 'package:co_fence/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyElevatedButton extends StatelessWidget {
  // 라우팅할 주소가 있다면 url을, 없다면 onPressed를 사용한다.
  final String? url;
  final Color? backgroundColor;
  final String buttonText;
  final VoidCallback? onPressed;

  const MyElevatedButton({
    super.key,
    this.url,
    this.backgroundColor = PRIMARY_COLOR,
    required this.buttonText,
    this.onPressed,
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
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 50),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
