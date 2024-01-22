import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/report/model/report_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReportCategoryScreen extends ConsumerWidget {
  const ReportCategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Report Category',
      drawer: const MyDrawer(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (ReportStatus status in ReportStatus.values)
              _buildElevatedButton(
                buttonText: status.code,
                category: status.displayName,
                ref: ref,
                context: context,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildElevatedButton({
    required String buttonText,
    required String category,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return Column(
      children: [
        MyElevatedButton(
          buttonText: buttonText,
          backgroundColor: Colors.white,
          textColor: PRIMARY_COLOR,
          onPressed: () {
            ref.read(reportStatusProvider.notifier).setReportStatus(
                  ReportStatus.values.firstWhere(
                    (element) => element.code == buttonText,
                  ),
                );
            context.go('/report/create?category=$category');
            print(ref.read(reportStatusProvider).code);
          },
        ),
        const Gap(16.0),
      ],
    );
  }
}
