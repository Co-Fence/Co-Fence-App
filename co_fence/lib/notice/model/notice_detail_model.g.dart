// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeDetailModel _$NoticeDetailModelFromJson(Map<String, dynamic> json) =>
    NoticeDetailModel(
      noticeSubject: json['noticeSubject'] as String,
      userName: json['userName'] as String,
      targetRoleType: $enumDecode(_$RoleEnumMap, json['targetRoleType']),
      createdAt: json['createdAt'] as String,
      noticeDetail: json['noticeDetail'] as String,
      noticeImage: (json['noticeImage'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$NoticeDetailModelToJson(NoticeDetailModel instance) =>
    <String, dynamic>{
      'noticeSubject': instance.noticeSubject,
      'userName': instance.userName,
      'targetRoleType': _$RoleEnumMap[instance.targetRoleType]!,
      'createdAt': instance.createdAt,
      'noticeDetail': instance.noticeDetail,
      'noticeImage': instance.noticeImage,
    };

const _$RoleEnumMap = {
  Role.ALL: 'ALL',
  Role.USER: 'USER',
  Role.ADMIN: 'ADMIN',
};
