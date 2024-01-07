import 'dart:io';

import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:co_fence/workplace/component/workplace_card.dart';
import 'package:co_fence/workplace/provider/workplace_id_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WorkplaceMainScreen extends ConsumerStatefulWidget {
  final String workplaceId;

  const WorkplaceMainScreen({
    required this.workplaceId,
    super.key,
  });

  @override
  _ManagementScreenState createState() => _ManagementScreenState();
}

class _ManagementScreenState extends ConsumerState<WorkplaceMainScreen> {
  final NOT_WORKING = '0';
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    final workplaceIdState = ref.watch(workplaceIdProvider);

    return DefaultLayout(
      backgroundColor: BACKGROUND_COLOR,
      context: context,
      appBarTitle: 'Your Workplace',
      drawer: const MyDrawer(),
      child: SafeArea(
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(10),
            Expanded(
              child: workplaceIdState == NOT_WORKING
                  ? const WorkplaceCard(
                      titleText: 'Your Workplace',
                      subTitleText:
                          'There is no work place at work.\nPlease search for work sites and participate.',
                      icon: Icons.info_outline_rounded,
                    )
                  : renderWorkplaceBody(ref),
            ),
            const Gap(20),
            Text('${GoRouterState.of(context).uri.queryParameters}'),
            workplaceIdState == NOT_WORKING
                ? const MyElevatedButton(
                    url: '/workplace/search',
                    buttonText: 'Search Your Workplace',
                  )
                : const MyElevatedButton(
                    url: '/report',
                    buttonText: 'Report',
                    backgroundColor: Colors.red,
                  ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

Widget renderWorkplaceBody(WidgetRef ref) {
  final userState = ref.watch(userProvider);
  return Column(
    children: [
      const Gap(10),
      ClipRRect(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              // 프로필 이미지
              CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(userState.profileImageUrl),
              ),
              const Gap(10),
              const Column(
                children: [
                  Text('이윤하님'),
                  Gap(60),
                  Text(
                    '서대문구 상가주택(2)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('에서 근무중입니다.'),
                ],
              ),
            ],
          ),
        ),
      ),
      const Text(
        'Your Workplace',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Gap(10),
      const Text(
        'You are currently working at this workplace.',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      const Gap(10),
      const Text(
        'If you want to report, please click the button below.',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      const Gap(10),
      const Text(
        'If you want to change your workplace, please search for your workplace.',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      const Gap(10),
    ],
  );
}
