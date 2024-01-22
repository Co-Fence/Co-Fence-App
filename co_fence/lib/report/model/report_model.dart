// ignore_for_file: constant_identifier_names

import 'package:co_fence/report/model/action_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  // 신고 제목
  String reportSubject;

  // 신고 내용
  String reportDetail;

  // 신고 상태
  ActionStatus actionStatus;

  // 신고 이미지 URl들
  List<String> reportImageUrl;

  // 작성 시간
  DateTime createdAt;

  ReportModel({
    required this.reportSubject,
    required this.reportDetail,
    required this.actionStatus,
    required this.createdAt,
    required this.reportImageUrl,
  });

  ReportModel copyWith({
    String? reportSubject,
    String? reportDetail,
    ActionStatus? actionStatus,
    DateTime? createdAt,
    List<String>? reportImageUrl,
  }) {
    return ReportModel(
        reportSubject: reportSubject ?? this.reportSubject,
        reportDetail: reportDetail ?? this.reportDetail,
        actionStatus: actionStatus ?? this.actionStatus,
        createdAt: createdAt ?? this.createdAt,
        reportImageUrl: reportImageUrl ?? this.reportImageUrl);
  }

  // fromJson
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  // toJson
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
