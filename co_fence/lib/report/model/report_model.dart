// ignore_for_file: constant_identifier_names

import 'package:co_fence/report/model/action_status.dart';
import 'package:co_fence/report/model/report_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  // 작성자 이름
  String? userName;
  // 신고 ID
  int? reportId;
  // 신고 제목
  String reportSubject;

  // 신고 내용
  String? reportDetail;

  // 신고 상태
  ActionStatus? actionStatus;

  // 신고 이미지 URl들
  List<String>? reportImageUrls;

  // 작성 시간
  DateTime createdAt;

  // 카테고리
  @JsonKey(
    fromJson: convertStringToReportStatus,
  )
  ReportStatus reportStatus;

  ReportModel({
    this.userName,
    this.reportId,
    required this.reportSubject,
    required this.reportDetail,
    required this.actionStatus,
    required this.reportStatus,
    required this.createdAt,
    required this.reportImageUrls,
  });

  ReportModel copyWith({
    String? userName,
    int? reportId,
    String? reportSubject,
    String? reportDetail,
    ActionStatus? actionStatus,
    ReportStatus? reportStatus,
    DateTime? createdAt,
    List<String>? reportImageUrls,
  }) {
    return ReportModel(
        userName: userName ?? this.userName,
        reportId: reportId ?? this.reportId,
        reportSubject: reportSubject ?? this.reportSubject,
        reportDetail: reportDetail ?? this.reportDetail,
        actionStatus: actionStatus ?? this.actionStatus,
        reportStatus: reportStatus ?? this.reportStatus,
        createdAt: createdAt ?? this.createdAt,
        reportImageUrls: reportImageUrls ?? this.reportImageUrls);
  }

  // fromJson
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  // toJson
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
