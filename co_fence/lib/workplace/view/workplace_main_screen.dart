// ignore_for_file: non_constant_identifier_names

import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/components/my_square_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:co_fence/workplace/component/workplace_card.dart';
import 'package:co_fence/workplace/provider/user_workplace_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
  _WorkplaceMainScreenState createState() => _WorkplaceMainScreenState();
}

class _WorkplaceMainScreenState extends ConsumerState<WorkplaceMainScreen> {
  final NOT_WORKING = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final dio = ref.watch(dioProvider);

    return DefaultLayout(
      context: context,
      appBarTitle: 'Your Workplace',
      drawer: const MyDrawer(),
      child: PopScope(
        canPop: false,
        child: SafeArea(
          bottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: userState.workplaceId == NOT_WORKING
                    ? const WorkplaceCard(
                        titleText: 'Your Workplace',
                        subTitleText:
                            'There is no work place at work.\nPlease search for work sites and participate.',
                        icon: Icons.info_outline_rounded,
                      )
                    : renderWorkplaceBody(context, ref),
              ),
              userState.workplaceId == NOT_WORKING
                  ? const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: MyElevatedButton(
                        url: '/workplace/search',
                        buttonText: 'Search Your Workplace',
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: MyElevatedButton(
                        url: '/report',
                        buttonText: 'Report',
                        backgroundColor: PRIMARY_COLOR,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// 현장 정보 프로필, 작업 현장 변경 버튼, 4개의 버튼
Widget renderWorkplaceBody(
  BuildContext context,
  WidgetRef ref,
) {
  final userState = ref.watch(userProvider);
  final screenSize = MediaQuery.of(context).size;
  final userWorkplaceState = ref.watch(userWorkplaceProvider);
  final dio = ref.watch(dioProvider);
  return Column(
    children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        child: Container(
          width: double.infinity,
          height: screenSize.height * 0.3,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IntrinsicWidth(
              child: Column(
                children: [
                  const Gap(20),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        // 프로필 이미지
                        CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              NetworkImage(userState.profileImageUrl),
                        ),
                        const Gap(20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // 유저의 이름
                              Text(
                                '${userState.name}님',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              userWorkplaceState.workPlaceName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              'You are working at',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      const Gap(20),
      // 현장 변경 버튼
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: MyElevatedButton(
          textColor: PRIMARY_COLOR,
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Change Workplace'),
                  content: const Text(
                      'Are you sure you want to change your workplace?'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text(
                        'No',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text('Yes'),
                      onPressed: () {
                        // 현장 탈퇴
                        dio.delete('$ip/wp/${userState.workplaceId}/checkout',
                            options: Options(
                              headers: {
                                'accessToken': 'true',
                              },
                            ));
                        Navigator.pop(context);
                        context.go('/workplace/search');
                      },
                    ),
                  ],
                );
              },
            );
          },
          buttonText: 'Change Workplace',
          backgroundColor: Colors.white,
        ),
      ),
      const Gap(30),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 40.0,
            mainAxisSpacing: 40.0,
            childAspectRatio: 1.5,
            crossAxisCount: 2,
            children: [
              MySquareButton(
                color: SECONDARY_COLOR,
                icon: Icons.person_outline,
                label: 'My Page',
                onTap: () => context.go('/mypage'),
              ),
              MySquareButton(
                color: PRIMARY_COLOR,
                icon: Icons.notifications_none_outlined,
                label: 'Notice',
                onTap: () => context.go('/notice'),
              ),
              MySquareButton(
                color: PRIMARY_COLOR,
                icon: Icons.book_outlined,
                label: 'Report List',
                onTap: () => context.go('/report_list'),
              ),
              MySquareButton(
                color: PRIMARY_COLOR,
                icon: Icons.phone_android_outlined,
                label: 'Contact',
                onTap: () => context.go('/contact'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
