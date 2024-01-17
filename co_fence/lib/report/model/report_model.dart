// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

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

@JsonSerializable()
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

  ReportModel copyWith({
    String? reportSubject,
    String? reportDetail,
    ReportStatus? reportStatus,
  }) {
    return ReportModel(
      reportSubject: reportSubject ?? this.reportSubject,
      reportDetail: reportDetail ?? this.reportDetail,
      reportStatus: reportStatus ?? this.reportStatus,
    );
  }

  // fromJson
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  // toJson
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
