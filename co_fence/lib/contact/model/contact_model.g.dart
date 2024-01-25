// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      imageUrl: json['imageUrl'] as String,
      nation: $enumDecode(_$NationEnumMap, json['nation']),
      role: $enumDecode(_$RoleEnumMap, json['role']),
    );

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'nation': _$NationEnumMap[instance.nation]!,
      'role': _$RoleEnumMap[instance.role]!,
    };

const _$NationEnumMap = {
  Nation.Korean: 'Korean',
  Nation.Foreigner: 'Foreigner',
};

const _$RoleEnumMap = {
  Role.USER: 'USER',
  Role.ADMIN: 'ADMIN',
};
