import 'package:co_fence/common/components/my_appbar.dart';
import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Report',
      drawer: const MyDrawer(),
      child: const Center(
        child: Text('Report'),
      ),
    );
  }
}
