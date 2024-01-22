import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/report/model/action_status.dart';
import 'package:co_fence/report/model/report_status.dart';
import 'package:co_fence/report/provider/report_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReportDetailScreen extends ConsumerStatefulWidget {
  final String reportId;
  const ReportDetailScreen({
    super.key,
    required this.reportId,
  });

  @override
  ConsumerState<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends ConsumerState<ReportDetailScreen> {
  TextEditingController _titleController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //fetchReportDetail();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _titleController = TextEditingController(
      text: ref.watch(reportProvider).reportSubject,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  fetchReportDetail() async {
    // final dio = ref.read(dioProvider);
    // final response = await dio.get(
    //   '$ip/wp/searchById?id=${userState.workplaceId}',
    //   options: Options(
    //     headers: {
    //       'accessToken': 'true',
    //     },
    //   ),
    // );
    // final workplace = WorkplaceModel.fromJson(response.data);
    // print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBarTitle: ref.watch(reportProvider).reportId.toString(),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.delete_outline,
            size: 30.0,
          ),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('Delete Report'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text(
                        'No',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        context.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () async {
                        context.pop(context);
                        // 삭제 api 호출
                        // 다시 리스트로 이동
                        context.go('/report_list');
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            const Gap(10.0),
            _renderLabel(),
            _renderTextField(
              controller: _titleController,
              hintText: '기계 결함',
              context: context,
              ref: ref,
            ),
            const Gap(10.0),
            _renderReportStatusDropdownMenu(
              context: context,
              ref: ref,
            ),
            const Gap(10.0),
            _renderActionStatusDropdownMenu(
              context: context,
              ref: ref,
            ),
            const Gap(10.0),
            _renderEditButton(
              onPressed: () async {
                await ref.read(reportProvider.notifier).createReport();
                context.go('/report_list');
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget _renderLabel() {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: Column(
      children: [
        const Row(
          children: [
            Text('Reporter: '),
            Text('송강'),
          ],
        ),
        Row(
          children: [
            const Text('Reported Date: '),
            Text(
              DateTime.now().toString().substring(0, 10),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _renderTextField({
  required TextEditingController controller,
  required String hintText,
  required BuildContext context,
  required WidgetRef ref,
}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      color: Colors.white,
      border: Border.all(
        color: PRIMARY_COLOR,
        width: 2.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Gap(
          20.0,
        ),
        const Expanded(
          flex: 1,
          child: Text(
            'Title',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const VerticalDivider(
          color: PRIMARY_COLOR,
          thickness: 2.0,
        ),
        const Gap(
          10.0,
        ),
        Expanded(
          flex: 2,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: ref.watch(reportProvider).reportSubject,
              border: InputBorder.none,
            ),
          ),
        ),
        const Gap(10.0),
      ],
    ),
  );
}

Widget _renderReportStatusDropdownMenu({
  required BuildContext context,
  required WidgetRef ref,
}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      color: Colors.white,
      border: Border.all(
        color: PRIMARY_COLOR,
        width: 2.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Gap(
          20.0,
        ),
        const Expanded(
          flex: 1,
          child: Text(
            'Category',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const VerticalDivider(
          color: PRIMARY_COLOR,
          thickness: 2.0,
        ),
        const Gap(
          10.0,
        ),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            value: ref.watch(reportProvider).reportStatus,
            onChanged: (value) {
              ref.read(reportProvider.notifier).updateReport(
                    reportStatus: value as ReportStatus,
                  );
            },
            items: ReportStatus.values.map((ReportStatus reportStatus) {
              return DropdownMenuItem(
                value: reportStatus,
                child: Text(
                  reportStatus.code,
                ),
              );
            }).toList(),
          ),
        ),
        const Gap(10.0),
      ],
    ),
  );
}

Widget _renderActionStatusDropdownMenu({
  required BuildContext context,
  required WidgetRef ref,
}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      color: Colors.white,
      border: Border.all(
        color: PRIMARY_COLOR,
        width: 2.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Gap(
          20.0,
        ),
        const Expanded(
          flex: 1,
          child: Text(
            'Status',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const VerticalDivider(
          color: PRIMARY_COLOR,
          thickness: 2.0,
        ),
        const Gap(
          10.0,
        ),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            value: ref.watch(reportProvider).actionStatus,
            onChanged: (value) {
              ref.read(reportProvider.notifier).updateReport(
                    actionStatus: value as ActionStatus,
                  );
            },
            items: ActionStatus.values.map((ActionStatus actionStatus) {
              return DropdownMenuItem(
                value: actionStatus,
                child: Text(
                  actionStatus.code,
                ),
              );
            }).toList(),
          ),
        ),
        const Gap(10.0),
      ],
    ),
  );
}

Widget _renderEditButton({
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: MyElevatedButton(
      buttonText: 'Edit',
      onPressed: onPressed,
    ),
  );
}
