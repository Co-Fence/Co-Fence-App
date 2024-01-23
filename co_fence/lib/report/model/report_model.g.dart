// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      userName: json['userName'] as String?,
      reportId: json['reportId'] as int?,
      reportSubject: json['reportSubject'] as String,
      reportDetail: json['reportDetail'] as String?,
      actionStatus:
          $enumDecodeNullable(_$ActionStatusEnumMap, json['actionStatus']),
      reportStatus: convertStringToReportStatus(json['reportStatus'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      reportImageUrls: (json['reportImageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'reportId': instance.reportId,
      'reportSubject': instance.reportSubject,
      'reportDetail': instance.reportDetail,
      'actionStatus': _$ActionStatusEnumMap[instance.actionStatus],
      'reportImageUrls': instance.reportImageUrls,
      'createdAt': instance.createdAt.toIso8601String(),
      'reportStatus': _$ReportStatusEnumMap[instance.reportStatus]!,
    };

const _$ActionStatusEnumMap = {
  ActionStatus.Before_Action: 'Before_Action',
  ActionStatus.In_Action: 'In_Action',
  ActionStatus.Work_Suspended: 'Work_Suspended',
  ActionStatus.Action_Completed: 'Action_Completed',
};

const _$ReportStatusEnumMap = {
  ReportStatus.FIRE_HAZARD: 'FIRE_HAZARD',
  ReportStatus.COLLAPSE_HAZARD: 'COLLAPSE_HAZARD',
  ReportStatus.MECHANICAL_FAILURE: 'MECHANICAL_FAILURE',
  ReportStatus.CHEMICAL_SPILL_HAZARD: 'CHEMICAL_SPILL_HAZARD',
  ReportStatus.ELECTRIC_HAZARD: 'ELECTRIC_HAZARD',
  ReportStatus.FALLING_HAZARD: 'FALLING_HAZARD',
  ReportStatus.EXPLOSION_HAZARD: 'EXPLOSION_HAZARD',
  ReportStatus.ETC_HAZARD: 'ETC_HAZARD',
};
