import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportMainScreen extends StatelessWidget {
  const ReportMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Report',
      drawer: const MyDrawer(),
      child: ElevatedButton(
        onPressed: () {
          context.go('/report_list/detail');
        },
        child: const Text('go to detail'),
      ),
    );
  }
}