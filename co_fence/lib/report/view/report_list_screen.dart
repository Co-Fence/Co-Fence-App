import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Report',
      drawer: const MyDrawer(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/report/create');
              },
              child: const Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/report/main');
              },
              child: const Text('Main'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/report/create/detail');
              },
              child: const Text('Create Detail'),
            ),
          ],
        ),
      ),
    );
  }
}
