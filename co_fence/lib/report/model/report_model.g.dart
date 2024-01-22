// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      reportSubject: json['reportSubject'] as String,
      reportDetail: json['reportDetail'] as String,
      actionStatus: $enumDecode(_$ActionStatusEnumMap, json['actionStatus']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      reportImageUrl: (json['reportImageUrl'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'reportSubject': instance.reportSubject,
      'reportDetail': instance.reportDetail,
      'actionStatus': _$ActionStatusEnumMap[instance.actionStatus]!,
      'reportImageUrl': instance.reportImageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$ActionStatusEnumMap = {
  ActionStatus.Before_Action: 'Before_Action',
  ActionStatus.In_Action: 'In_Action',
  ActionStatus.Work_Suspended: 'Work_Suspended',
  ActionStatus.Action_Completed: 'Action_Completed',
};
