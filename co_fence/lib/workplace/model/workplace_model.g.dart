// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workplace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkplaceModel _$WorkplaceModelFromJson(Map<String, dynamic> json) =>
    WorkplaceModel(
      workplaceId: json['workplaceId'] as String,
      workplaceName: json['workplaceName'] as String,
      workplaceAddress: json['workplaceAddress'] as String,
    );

Map<String, dynamic> _$WorkplaceModelToJson(WorkplaceModel instance) =>
    <String, dynamic>{
      'workplaceId': instance.workplaceId,
      'workplaceName': instance.workplaceName,
      'workplaceAddress': instance.workplaceAddress,
    };
