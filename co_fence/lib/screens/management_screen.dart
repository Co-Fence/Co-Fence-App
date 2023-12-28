import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/riverpods/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManagementScreen extends ConsumerStatefulWidget {
  const ManagementScreen({super.key});

  @override
  ConsumerState<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends ConsumerState<ManagementScreen> {
  @override
  void initState() {
    fetchUserInfomation();
  }

  void fetchUserInfomation() {
    final userState = ref.read(userProvider);
    // 회원의 정보 출력
    print('User Information:');
    print('Name: ${userState.name}');
    print('Email: ${userState.email}');
    print('Nation: ${userState.nation}');
    print('Gender: ${userState.gender}');
    print('Birth: ${userState.birth}');
    print('Phone Number: ${userState.phoneNumber}');
    print('Profile Image: ${userState.profileImage?.path}');
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Management',
      child: Center(
        child: Text('Management'),
      ),
    );
  }
}
