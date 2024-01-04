import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    //fetchUserWorkspace();
  }

  void fetchUserInfomation() {
    // user/me 같은거로 요청해서 저장해야함
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

  // 유저가 현재 일하고 있는 워크스페이스를 가져옴
  fetchUserWorkspace() {}

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
