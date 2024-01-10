import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int page;
  final int size;

  const PaginationParams({
    required this.page,
    required this.size,
  });

  // copyWith
  PaginationParams copyWith({
    int? page,
    int? size,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
