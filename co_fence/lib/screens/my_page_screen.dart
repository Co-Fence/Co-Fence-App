import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text(
          'MyPage',
        ),
      ),
    );
  }
}
