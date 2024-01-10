// ignore_for_file: non_constant_identifier_names

import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/components/my_grid_view.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:co_fence/workplace/component/workplace_card.dart';
import 'package:co_fence/workplace/provider/workplace_id_provider.dart';
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
  final NOT_WORKING = '0';

  @override
  Widget build(BuildContext context) {
    final workplaceIdState = ref.watch(workplaceIdProvider);
    final queryParameters = GoRouterState.of(context).uri.queryParameters;
    final dio = ref.watch(dioProvider);

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
              child: queryParameters['workplaceId'] == NOT_WORKING
                  ? const WorkplaceCard(
                      titleText: 'Your Workplace',
                      subTitleText:
                          'There is no work place at work.\nPlease search for work sites and participate.',
                      icon: Icons.info_outline_rounded,
                    )
                  : renderWorkplaceBody(context, ref),
            ),
            const Gap(20),
            Text('${GoRouterState.of(context).uri.queryParameters}'),
            queryParameters['workplaceId'] == NOT_WORKING
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

Widget renderWorkplaceBody(
  BuildContext context,
  WidgetRef ref,
) {
  final userState = ref.watch(userProvider);
  final screenSize = MediaQuery.of(context).size;
  return Column(
    children: [
      const Gap(10),
      ClipRRect(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
        child: Container(
          width: double.infinity,
          height: screenSize.height * 0.3,
          decoration: const BoxDecoration(color: Colors.white),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                userState.name,
                                style: const TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                              Text(
                                  '${GoRouterState.of(context).uri.queryParameters}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '서대문구 상가주택(2)',
                              style: TextStyle(
                                fontSize: 24,
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
      const MyElevatedButton(
        url: '/workplace/search',
        buttonText: 'Change Workplace',
        backgroundColor: PRIMARY_COLOR,
      ),
    ],
  );
}
