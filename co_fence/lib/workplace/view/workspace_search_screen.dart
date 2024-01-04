import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkspaceSearchScreen extends StatelessWidget {
  const WorkspaceSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Workspace Search',
      child: const Center(
        child: Text('Workspace Search'),
      ),
    );
  }
}
