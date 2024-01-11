import 'package:json_annotation/json_annotation.dart';

part 'workplace_model.g.dart';

@JsonSerializable()
class WorkplaceModel {
  final int workPlaceId;
  final String workPlaceName;
  final String workPlaceAddress;

  WorkplaceModel({
    required this.workPlaceId,
    required this.workPlaceName,
    required this.workPlaceAddress,
  });

  WorkplaceModel copyWith({
    int? workPlaceId,
    String? workPlaceName,
    String? workPlaceAddress,
  }) {
    return WorkplaceModel(
      workPlaceId: workPlaceId ?? this.workPlaceId,
      workPlaceName: workPlaceName ?? this.workPlaceName,
      workPlaceAddress: workPlaceAddress ?? this.workPlaceAddress,
    );
  }

  factory WorkplaceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkplaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkplaceModelToJson(this);

  // factory WorkplaceModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return WorkplaceModel(
  //     workPlaceId: json['workPlaceId'],
  //     workPlaceName: json['workPlaceName'],
  //     workPlaceAddress: json['workPlaceAddress'],
  //   );
  // }
}
