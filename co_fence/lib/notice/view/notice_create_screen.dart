import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class NoticeCreateScreen extends StatelessWidget {
  const NoticeCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Create Notice',
      child: const Center(
        child: Text(
          'create notice',
        ),
      ),
    );
  }
}
