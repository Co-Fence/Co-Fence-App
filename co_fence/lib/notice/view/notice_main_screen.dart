import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoticeMainScreen extends StatelessWidget {
  const NoticeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Notice',
      drawer: const MyDrawer(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/notice/detail');
              },
              child: const Text(
                'go to detail',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/notice/create');
              },
              child: const Text(
                'go to create',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
