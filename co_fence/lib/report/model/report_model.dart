enum ReportStatus {
  // 조치전
  BEFORE_ACTION,
  // 조치중
  IN_ACTION,
  // 중단된 작업
  WORK_SUSPEND,
  // 조치 완료
  ACTION_COMPLETED,
}

class ReportModel {
  // 공지사항 제목
  String reportSubject;

  // 공지사항 내용
  String reportDetail;

  // 공지사항 상태
  ReportStatus reportStatus;

  ReportModel({
    required this.reportSubject,
    required this.reportDetail,
    required this.reportStatus,
  });
}
