import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class NoticeDetailScreen extends StatelessWidget {
  final String noticeId;
  const NoticeDetailScreen({
    super.key,
    required this.noticeId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: noticeId,
      child: const Center(
        child: Text(
          'detail page',
        ),
      ),
    );
  }
}
