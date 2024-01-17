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
          reportStatus: ReportStatus.BEFORE_ACTION,
        ));

  void setReportSubject(String reportSubject) {
    state = state.copyWith(reportSubject: reportSubject);
  }

  void setReportDetail(String reportDetail) {
    state = state.copyWith(reportDetail: reportDetail);
  }

  void setReportStatus(ReportStatus reportStatus) {
    state = state.copyWith(reportStatus: reportStatus);
  }

  Future<void> createReport() async {
    try {
      await repository.createReport(
        reportSubject: state.reportSubject,
        reportDetail: state.reportDetail,
        reportStatus: state.reportStatus.toString(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
