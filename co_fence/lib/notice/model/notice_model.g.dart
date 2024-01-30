// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) => NoticeModel(
      noticeId: json['noticeId'] as int,
      noticeSubject: json['noticeSubject'] as String,
      targetRoleType: $enumDecode(_$RoleEnumMap, json['targetRoleType']),
    );

Map<String, dynamic> _$NoticeModelToJson(NoticeModel instance) =>
    <String, dynamic>{
      'noticeId': instance.noticeId,
      'noticeSubject': instance.noticeSubject,
      'targetRoleType': _$RoleEnumMap[instance.targetRoleType]!,
    };

const _$RoleEnumMap = {
  Role.USER: 'USER',
  Role.ADMIN: 'ADMIN',
};
