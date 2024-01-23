import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/utils/utils.dart';
import 'package:co_fence/report/components/report_card.dart';
import 'package:co_fence/report/model/action_status.dart';
import 'package:co_fence/report/model/report_model.dart';
import 'package:co_fence/report/model/report_status.dart';
import 'package:co_fence/report/provider/report_provider.dart';
import 'package:co_fence/report/service/report_services.dart';
import 'package:co_fence/workplace/provider/user_workplace_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReportListScreen extends ConsumerStatefulWidget {
  const ReportListScreen({super.key});

  @override
  ConsumerState<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends ConsumerState<ReportListScreen> {
  DateTime? startDate;
  DateTime? endDate;

  final reportListProvider = StateProvider<List<ReportModel>?>((ref) {
    return [];
  });

  @override
  Widget build(BuildContext context) {
    final reportStatusState = ref.watch(reportStatusProvider);
    final actionsStatusState = ref.watch(actionStatusProvider);
    final dio = ref.read(dioProvider);

    return DefaultLayout(
      context: context,
      appBarTitle: 'Report List',
      drawer: const MyDrawer(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(
                    15.0,
                  ),
                  _renderWorkplaceName(
                    context,
                    ref,
                  ),
                  const Gap(
                    10.0,
                  ),
                  _renderReportDate(
                    context,
                    startDate,
                    endDate,
                    onStartDateSelected: (selectedDate) {
                      setState(() {
                        startDate = selectedDate;
                      });
                    },
                    onEndDateSelected: (selectedDate) {
                      setState(() {
                        endDate = selectedDate;
                      });
                    },
                  ),
                  const Gap(
                    10.0,
                  ),
                  _renderReportStatus(
                    ref,
                    context,
                    onStatusSelected: (selectedStatus) {
                      ref
                          .read(reportStatusProvider.notifier)
                          .setReportStatus(selectedStatus!);
                    },
                  ),
                  const Gap(
                    10.0,
                  ),
                  _renderActionStatus(
                    ref,
                    context,
                    onStatusSelected: (selectedStatus) {
                      ref
                          .read(actionStatusProvider.notifier)
                          .setReportStatus(selectedStatus!);
                    },
                    onSearchPressed: () {
                      if (startDate == null || endDate == null) {
                        showSnackBar(
                          context,
                          'Please select date',
                        );
                        return;
                      }
                      // 검색 api 호출
                      dio.post('$ip/report/search?page=0&size=10',
                          options: Options(headers: {
                            'accessToken': 'true',
                          }),
                          data: {
                            'startDateTime': startDate!.toIso8601String(),
                            'endDateTime': endDate!.toIso8601String(),
                            'reportStatus': reportStatusState.displayName,
                            'actionStatus': actionsStatusState.displayName,
                          }).then((value) {
                        if (value.statusCode == 200) {
                          ref.read(reportListProvider.notifier).state = (value
                                  .data['content'] as List<dynamic>?)
                              ?.map(
                                (element) => ReportModel.fromJson(
                                    element as Map<String, dynamic>),
                              )
                              .whereType<
                                  ReportModel>() // null이 아닌 ReportModel만 필터링
                              .toList();
                          setState(() {});
                        } else if (value.statusCode == 404) {
                          showSnackBar(context, 'No Report Found');
                        }
                      }).catchError((error) {
                        print('Error: $error');
                        showSnackBar(context, 'An Error Occured');
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  ReportModel report = ref.watch(reportListProvider)![index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final resp = await ReportServices().fetchReportDetail(
                          ref: ref,
                          reportId: report.reportId.toString(),
                        );
                        ref.read(reportProvider.notifier).updateReport(
                              reportId: report.reportId,
                              userName: resp.userName,
                              createdAt: resp.createdAt,
                              reportImageUrls: resp.reportImageUrls,
                              reportDetail: resp.reportDetail,
                              reportSubject: resp.reportSubject,
                              reportStatus: resp.reportStatus,
                              actionStatus: resp.actionStatus,
                            );

                        context.go(
                            '/report_list/detail?reportId=${report.reportId}');
                      },
                      child: ReportCard.fromModel(
                        model: report,
                      ),
                    ),
                  );
                },
                childCount:
                    ref.watch(reportListProvider.notifier).state!.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 현재 작업현장 이름
Widget _renderWorkplaceName(
  BuildContext context,
  WidgetRef ref,
) {
  final userWorkplaceState = ref.watch(userWorkplaceProvider);
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.05,
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
            'Workplace',
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
          child: Text(
            userWorkplaceState.workPlaceName,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(10.0),
      ],
    ),
  );
}

// 검색할 날짜 선택
Widget _renderReportDate(
  BuildContext context,
  DateTime? startDate,
  DateTime? endDate, {
  required Function(DateTime?) onStartDateSelected,
  required Function(DateTime?) onEndDateSelected,
}) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.05,
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
            'Report Date',
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
        Expanded(
          flex: 1,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: PRIMARY_COLOR,
            ),
            onPressed: () async {
              final selectedDate = await showDatePicker(
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: PRIMARY_COLOR,
                      ),
                    ),
                    child: child!,
                  );
                },
                context: context,
                initialDate: startDate ?? DateTime.now(),
                firstDate: DateTime(2018),
                lastDate: endDate ?? DateTime.now(),
              );

              // 유효성 검사
              if (selectedDate != null) {
                onStartDateSelected(selectedDate);
              } else {
                return;
              }
            },
            child: Text(startDate != null
                ? startDate.toString().substring(0, 10)
                : 'Start Date'),
          ),
        ),
        const VerticalDivider(
          color: PRIMARY_COLOR,
          thickness: 2.0,
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: PRIMARY_COLOR,
            ),
            onPressed: () async {
              final selectedDate = await showDatePicker(
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: PRIMARY_COLOR,
                      ),
                    ),
                    child: child!,
                  );
                },
                context: context,
                initialDate: endDate ?? DateTime.now(),
                firstDate: startDate ?? DateTime(2018),
                lastDate: DateTime.now(),
              );

              // 유효성 검사
              if (selectedDate != null) {
                // 마지막 시간을 23:59:59로 설정
                final lastTime = TimeOfDay.fromDateTime(
                  DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day, 23, 59, 59),
                );
                final lastDateTime = DateTime(
                        selectedDate.year, selectedDate.month, selectedDate.day)
                    .add(Duration(
                        hours: lastTime.hour,
                        minutes: lastTime.minute,
                        seconds: lastTime.period == DayPeriod.am ? 0 : 59));
                onEndDateSelected(lastDateTime);
              } else {
                return;
              }
            },
            child: Text(endDate != null
                ? endDate.toString().substring(0, 10)
                : 'End Date'),
          ),
        ),
        const Gap(
          10.0,
        ),
      ],
    ),
  );
}

// 신고 카테고리
// DropdownButton을 사용하여 선택
// _renderReportDate와 비슷하게 구현
Widget _renderReportStatus(
  WidgetRef ref,
  BuildContext context, {
  required Function(ReportStatus?)? onStatusSelected,
}) {
  final reportStatusState = ref.watch(reportStatusProvider);
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.05,
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
          child: DropdownButton<ReportStatus>(
            underline: Container(),
            isExpanded: true,
            value: reportStatusState,
            onChanged: onStatusSelected,
            items: ReportStatus.values
                .map(
                  (ReportStatus reportstatus) => DropdownMenuItem<ReportStatus>(
                    value: reportstatus,
                    child: Text(reportstatus.code),
                  ),
                )
                .toList(),
          ),
        ),
        const Gap(
          10.0,
        ),
      ],
    ),
  );
}

// ActionStatus를 고르는 위젯
Widget _renderActionStatus(
  WidgetRef ref,
  BuildContext context, {
  required Function(ActionStatus?)? onStatusSelected,
  required VoidCallback onSearchPressed,
}) {
  final actionStatusState = ref.watch(actionStatusProvider);
  return Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.05,
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
              child: DropdownButton<ActionStatus>(
                underline: Container(),
                isExpanded: true,
                value: actionStatusState,
                onChanged: onStatusSelected,
                items: ActionStatus.values
                    .map(
                      (ActionStatus actionStatus) =>
                          DropdownMenuItem<ActionStatus>(
                        value: actionStatus,
                        child: Text(actionStatus.code),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Gap(
              5.0,
            ),
          ],
        ),
      ),
      const Gap(
        10.0,
      ),
      InkWell(
        onTap: onSearchPressed,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: const BoxDecoration(
            color: PRIMARY_COLOR,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.0,
              ),
            ),
          ),
          child: const Center(
            child: Text(
              'Search',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
