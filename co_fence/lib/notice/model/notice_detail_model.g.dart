// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeDetailModel _$NoticeDetailModelFromJson(Map<String, dynamic> json) =>
    NoticeDetailModel(
      noticeSubject: json['noticeSubject'] as String,
      userName: json['userName'] as String,
      targetRole: $enumDecode(_$RoleEnumMap, json['targetRole']),
      createdAt: json['createdAt'] as String,
      noticeDetail: json['noticeDetail'] as String,
      noticeImageUrl: (json['noticeImageUrl'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$NoticeDetailModelToJson(NoticeDetailModel instance) =>
    <String, dynamic>{
      'noticeSubject': instance.noticeSubject,
      'userName': instance.userName,
      'targetRole': _$RoleEnumMap[instance.targetRole]!,
      'createdAt': instance.createdAt,
      'noticeDetail': instance.noticeDetail,
      'noticeImageUrl': instance.noticeImageUrl,
    };

const _$RoleEnumMap = {
  Role.ALL: 'ALL',
  Role.USER: 'USER',
  Role.ADMIN: 'ADMIN',
};
