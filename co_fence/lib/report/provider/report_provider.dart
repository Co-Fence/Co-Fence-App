import 'package:co_fence/report/model/action_status.dart';
import 'package:co_fence/report/model/report_model.dart';
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
          reportSubject: '',
          reportDetail: '',
          actionStatus: ActionStatus.Before_Action,
          createdAt: DateTime.now(),
          reportImageUrl: [],
        ));

  void updateReport({
    String? reportSubject,
    String? reportDetail,
    ActionStatus? reportStatus,
    List<String>? reportImageUrl,
  }) {
    state = state.copyWith(
      reportSubject: reportSubject ?? state.reportSubject,
      reportDetail: reportDetail ?? state.reportDetail,
      actionStatus: reportStatus ?? state.actionStatus,
      reportImageUrl: reportImageUrl ?? state.reportImageUrl,
    );
  }

  Future<void> createReport() async {
    try {
      await repository.createReport(
        reportSubject: state.reportSubject,
        reportDetail: state.reportDetail,
        reportStatus: state.actionStatus.toString(),
        reportImageUrl: state.reportImageUrl,
      );
    } catch (e) {
      rethrow;
    }
  }
}
