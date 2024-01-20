import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/workplace/provider/user_workplace_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportListScreen extends ConsumerWidget {
  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userWorkplaceState = ref.watch(userWorkplaceProvider);
    return DefaultLayout(
      context: context,
      appBarTitle: 'Report List',
      drawer: const MyDrawer(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userWorkplaceState.workPlaceName),
            const Text('Report List Screen'),
          ],
        ),
      ),
    );
  }
}
