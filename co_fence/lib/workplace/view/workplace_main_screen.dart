import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WorkplaceMainScreen extends ConsumerStatefulWidget {
  const WorkplaceMainScreen({super.key});

  @override
  ConsumerState<WorkplaceMainScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends ConsumerState<WorkplaceMainScreen> {
  final dio = Dio();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Your Workplace',
      drawer: const MyDrawer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: const Center(
              child: Text('workplace'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/workplace/search');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                PRIMARY_COLOR,
              ),
            ),
            child: const Text(
              'Search Workpace',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
