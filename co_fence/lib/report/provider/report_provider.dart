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
          userName: '',
          reportDetail: '',
          actionStatus: ActionStatus.Before_Action,
          createdAt: DateTime.now(),
          reportStatus: ReportStatus.FIRE_HAZARD,
          reportImageUrls: [],
        ));

  void updateReport({
    int? reportId,
    String? userName,
    String? reportSubject,
    String? reportDetail,
    DateTime? createdAt,
    ActionStatus? actionStatus,
    ReportStatus? reportStatus,
    List<String>? reportImageUrls,
  }) {
    state = state.copyWith(
      userName: userName ?? state.userName,
      reportId: reportId ?? state.reportId,
      reportSubject: reportSubject ?? state.reportSubject,
      reportDetail: reportDetail ?? state.reportDetail,
      actionStatus: actionStatus ?? state.actionStatus,
      createdAt: createdAt ?? state.createdAt,
      reportImageUrls: reportImageUrls ?? state.reportImageUrls,
      reportStatus: reportStatus ?? state.reportStatus,
    );
  }

  Future<void> editReport() async {
    try {
      await repository.updateReport(
        reportId: state.reportId!,
        reportSubject: state.reportSubject,
        reportStatus: state.reportStatus.displayName,
        actionStatus: state.actionStatus!.displayName,
      );
    } catch (e) {
      rethrow;
    }
  }
}
