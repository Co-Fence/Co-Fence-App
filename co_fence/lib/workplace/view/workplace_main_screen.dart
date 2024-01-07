import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/workplace/component/workplace_card.dart';
import 'package:co_fence/workplace/provider/workplace_id_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

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
  final NOT_WORKING = 0;
  final dio = Dio();

  @override
  void initState() {
    super.initState();
  }

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
                  : renderWorkplaceBody(),
            ),
            // workplaceId ++ 1
            ElevatedButton(
              onPressed: () {
                ref.read(workplaceIdProvider.notifier).state++;
              },
              child: const Text('workplaceId ++ 1'),
            ),

            const Gap(20),
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

Widget renderWorkplaceBody() {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
      ),
      Ink(
        child: InkWell(
          onTap: () {},
          child: const Text('data'),
        ),
      )
    ],
  );
}
