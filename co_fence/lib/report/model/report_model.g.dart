// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      reportSubject: json['reportSubject'] as String,
      reportDetail: json['reportDetail'] as String,
      reportStatus: $enumDecode(_$ReportStatusEnumMap, json['reportStatus']),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'reportSubject': instance.reportSubject,
      'reportDetail': instance.reportDetail,
      'reportStatus': _$ReportStatusEnumMap[instance.reportStatus]!,
    };

const _$ReportStatusEnumMap = {
  ReportStatus.BEFORE_ACTION: 'BEFORE_ACTION',
  ReportStatus.IN_ACTION: 'IN_ACTION',
  ReportStatus.WORK_SUSPEND: 'WORK_SUSPEND',
  ReportStatus.ACTION_COMPLETED: 'ACTION_COMPLETED',
};
