import 'package:co_fence/report/model/action_status.dart';
import 'package:co_fence/report/model/report_model.dart';
import 'package:co_fence/report/model/report_status.dart';
import 'package:co_fence/report/repository/report_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportProvider = StateNotifierProvider<ReportStateNotifier, ReportModel>(
  (ref) {
    final repository = ref.watch(reportRepositoryProvider);
    final notifier = ReportStateNotifier(
      repository: repository,
    );

    return notifier;
  },
);

class ReportStateNotifier extends StateNotifier<ReportModel> {
  final ReportRepository repository;

  ReportStateNotifier({
    required this.repository,
  }) : super(ReportModel(
          reportId: 0,
          reportSubject: '',
          reportDetail: '',
          actionStatus: ActionStatus.Before_Action,
          createdAt: DateTime.now(),
          reportStatus: ReportStatus.FIRE_HAZARD,
          reportImageUrl: [],
        ));

  void updateReport({
    int? reportId,
    String? reportSubject,
    String? reportDetail,
    ActionStatus? actionStatus,
    ReportStatus? reportStatus,
    List<String>? reportImageUrl,
  }) {
    state = state.copyWith(
      reportId: reportId ?? state.reportId,
      reportSubject: reportSubject ?? state.reportSubject,
      reportDetail: reportDetail ?? state.reportDetail,
      actionStatus: actionStatus ?? state.actionStatus,
      reportImageUrl: reportImageUrl ?? state.reportImageUrl,
      reportStatus: reportStatus ?? state.reportStatus,
    );
  }

  Future<void> createReport() async {
    try {
      await repository.createReport(
        reportSubject: state.reportSubject,
        reportDetail: state.reportDetail!,
        reportStatus: state.reportStatus.toString(),
        reportImageUrl: state.reportImageUrl!,
      );
    } catch (e) {
      rethrow;
    }
  }
}
