// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) => NoticeModel(
      existImage: json['existImage'] as bool,
      noticeId: json['noticeId'] as int,
      noticeSubject: json['noticeSubject'] as String,
      targetRoleType: Role.fromCode(json['targetRoleType'] as String),
    );

Map<String, dynamic> _$NoticeModelToJson(NoticeModel instance) =>
    <String, dynamic>{
      'noticeId': instance.noticeId,
      'noticeSubject': instance.noticeSubject,
      'targetRoleType': _$RoleEnumMap[instance.targetRoleType]!,
      'existImage': instance.existImage,
    };

const _$RoleEnumMap = {
  Role.ALL: 'ALL',
  Role.USER: 'USER',
  Role.ADMIN: 'ADMIN',
};
