// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) => NoticeModel(
      noticeId: json['noticeId'] as int,
      noticeSubject: json['noticeSubject'] as String,
      targetRoletype: Role.fromCode(json['targetRoletype'] as String),
    );

Map<String, dynamic> _$NoticeModelToJson(NoticeModel instance) =>
    <String, dynamic>{
      'noticeId': instance.noticeId,
      'noticeSubject': instance.noticeSubject,
      'targetRoletype': _$RoleEnumMap[instance.targetRoletype]!,
    };

const _$RoleEnumMap = {
  Role.ALL: 'ALL',
  Role.USER: 'USER',
  Role.ADMIN: 'ADMIN',
};
