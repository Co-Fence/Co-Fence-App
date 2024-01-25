import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/utils/utils.dart';
import 'package:co_fence/report/model/action_status.dart';
import 'package:co_fence/report/model/report_status.dart';
import 'package:co_fence/report/provider/report_provider.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReportDetailScreen extends ConsumerStatefulWidget {
  const ReportDetailScreen({
    super.key,
  });

  @override
  ConsumerState<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends ConsumerState<ReportDetailScreen> {
  final TextEditingController _titleController = TextEditingController();
  bool isLoading = false;
  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _titleController.text = ref.watch(reportProvider).reportSubject;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBarTitle: 'Report Detail',
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
                  content: const Text(
                      'Are you sure you want to delete this report?'),
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
                        await ref.read(reportProvider.notifier).deleteReport();
                        showSnackBar(context, "Delete Successfully");
                        context.go('/workplace');
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
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const Gap(10.0),
                    _renderLabel(ref),
                    _renderTextField(
                      controller: _titleController,
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
                    _renderImageListPageBuilder(
                      context: context,
                      ref: ref,
                    ),
                    const Gap(10.0),
                    _renderReportDetail(
                      context: context,
                      ref: ref,
                    ),
                    const Gap(10.0),
                    _renderEditButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderLabel(
    WidgetRef ref,
  ) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              const Text('Reporter: '),
              Text('${ref.watch(reportProvider).userName}'),
            ],
          ),
          Row(
            children: [
              const Text('Reported Date: '),
              Text(
                ref.watch(reportProvider).createdAt.toString().substring(0, 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderTextField({
    required TextEditingController controller,
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
              decoration: const InputDecoration(
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
              onChanged: (ReportStatus? value) {
                if (value != null) {
                  ref.read(reportProvider.notifier).updateReport(
                        reportStatus: value,
                      );
                }
              },
              items: ReportStatus.values.map((ReportStatus reportStatus) {
                return DropdownMenuItem<ReportStatus>(
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

  Widget _renderImageListPageBuilder({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: PRIMARY_COLOR,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: ref.watch(reportProvider).reportImageUrls!.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    firebasePrefix(isReport: true) +
                        ref.watch(reportProvider).reportImageUrls![index],
                    width: 300.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          _renderPageIndicator(),
        ],
      ),
    );
  }

  Widget _renderReportDetail({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return Container(
      width: double.infinity,
      height: 200,
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '${ref.watch(reportProvider).reportDetail}',
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _renderEditButton() {
    return MyElevatedButton(
      buttonText: 'Edit',
      onPressed: () async {
        if (ref.read(userProvider).role == Role.USER) {
          showSnackBar(context, "You don't have permission");
          return;
        }
        // update reportSubject
        ref.read(reportProvider.notifier).updateReport(
              reportSubject: _titleController.text,
            );
        // cupertino dialog
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Edit Report'),
              content: const Text('Are you sure you want to edit this report?'),
              actions: [
                CupertinoDialogAction(
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: Colors.red,
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
                    // 수정 api 호출
                    await ref.read(reportProvider.notifier).editReport();
                    showSnackBar(context, "Edit Successfully");
                    context.go('/workplace');
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _renderPageIndicator() {
    int dotsCount = (ref.watch(reportProvider).reportImageUrls?.length ?? 0);
    dotsCount = dotsCount > 0 ? dotsCount : 1;

    return DotsIndicator(
      dotsCount: dotsCount,
      position: currentPage,
      decorator: const DotsDecorator(
        color: Colors.grey,
        activeColor: PRIMARY_COLOR,
      ),
    );
  }
}
