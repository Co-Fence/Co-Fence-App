import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/data.dart';

class WorkspaceMainScreen extends ConsumerStatefulWidget {
  const WorkspaceMainScreen({super.key});

  @override
  ConsumerState<WorkspaceMainScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends ConsumerState<WorkspaceMainScreen> {
  final dio = Dio();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Your Workspace',
      drawer: const MyDrawer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: const Center(
              child: Text('workspace'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/workspace/search');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                PRIMARY_COLOR,
              ),
            ),
            child: const Text(
              'Create Workspace',
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
