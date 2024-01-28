// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetailModel _$ContactDetailModelFromJson(Map<String, dynamic> json) =>
    ContactDetailModel(
      userId: json['userId'] as int?,
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      nation: $enumDecode(_$NationEnumMap, json['nation']),
      roleType: $enumDecode(_$RoleEnumMap, json['roleType']),
    );

Map<String, dynamic> _$ContactDetailModelToJson(ContactDetailModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'profileImageUrl': instance.profileImageUrl,
      'nation': _$NationEnumMap[instance.nation]!,
      'roleType': _$RoleEnumMap[instance.roleType]!,
    };

const _$NationEnumMap = {
  Nation.Korean: 'Korean',
  Nation.Foreigner: 'Foreigner',
};

const _$RoleEnumMap = {
  Role.USER: 'USER',
  Role.ADMIN: 'ADMIN',
};
