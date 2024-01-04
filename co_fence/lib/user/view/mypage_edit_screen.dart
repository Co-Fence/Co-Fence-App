import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class MyPageEditScreen extends StatelessWidget {
  const MyPageEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'My Page Edit',
      child: const Center(
        child: Text('My Page Edit'),
      ),
    );
  }
}
