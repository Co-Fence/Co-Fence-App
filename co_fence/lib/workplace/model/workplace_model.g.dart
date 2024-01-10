// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workplace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkplaceModel _$WorkplaceModelFromJson(Map<String, dynamic> json) =>
    WorkplaceModel(
      workPlaceId: json['workPlaceId'] as int,
      workPlaceName: json['workPlaceName'] as String,
      workPlaceAddress: json['workPlaceAddress'] as String,
    );

Map<String, dynamic> _$WorkplaceModelToJson(WorkplaceModel instance) =>
    <String, dynamic>{
      'workPlaceId': instance.workPlaceId,
      'workPlaceName': instance.workPlaceName,
      'workPlaceAddress': instance.workPlaceAddress,
    };
