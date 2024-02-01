// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      roleType: Role.fromCode(json['roleType'] as String),
    );

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'profileImageUrl': instance.profileImageUrl,
      'roleType': _$RoleEnumMap[instance.roleType]!,
    };

const _$RoleEnumMap = {
  Role.ALL: 'ALL',
  Role.USER: 'USER',
  Role.ADMIN: 'ADMIN',
};
