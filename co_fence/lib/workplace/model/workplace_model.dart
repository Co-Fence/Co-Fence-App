import 'package:json_annotation/json_annotation.dart';

part 'workplace_model.g.dart';

@JsonSerializable()
class WorkplaceModel {
  final String workplaceId;
  final String workplaceName;
  final String workplaceAddress;

  WorkplaceModel({
    required this.workplaceId,
    required this.workplaceName,
    required this.workplaceAddress,
  });

  factory WorkplaceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkplaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkplaceModelToJson(this);

  // factory WorkplaceModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return WorkplaceModel(
  //     workplaceId: json['workplaceId'],
  //     workplaceName: json['workplaceName'],
  //     workplaceAddress: json['workplaceAddress'],
  //   );
  // }
}
