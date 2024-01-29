// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetailModel _$ContactDetailModelFromJson(Map<String, dynamic> json) =>
    ContactDetailModel(
      email: json['email'] as int?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      nationality: $enumDecode(_$NationEnumMap, json['nationality']),
      roleType: Role.fromCode(json['roleType'] as String),
    );

Map<String, dynamic> _$ContactDetailModelToJson(ContactDetailModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'profileImageUrl': instance.profileImageUrl,
      'nationality': _$NationEnumMap[instance.nationality]!,
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
