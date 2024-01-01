import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkspaceMainScreen extends ConsumerStatefulWidget {
  const WorkspaceMainScreen({super.key});

  @override
  ConsumerState<WorkspaceMainScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends ConsumerState<WorkspaceMainScreen> {
  @override
  void initState() {
    super.initState();
    fetchUserInfomation();
  }

  void fetchUserInfomation() {
    final userState = ref.read(userProvider);
    // 회원의 정보 출력
    print('User Information:');
    print('Name: ${userState.name}');
    print('Email: ${userState.email}');
    print('Role: ${userState.role}');
    print('Nation: ${userState.nation}');
    print('Phone Number: ${userState.phoneNumber}');
    print('Profile Image: ${userState.profileImageUrl}');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Container(
        child: const Center(
          child: Text('Management'),
        ),
      ),
    );
  }
}
