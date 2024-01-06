class WorkplaceModel {
  final String workplaceId;
  final String workplaceName;
  final String workplaceAddress;

  WorkplaceModel({
    required this.workplaceId,
    required this.workplaceName,
    required this.workplaceAddress,
  });

  factory WorkplaceModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return WorkplaceModel(
      workplaceId: json['workplaceId'],
      workplaceName: json['workplaceName'],
      workplaceAddress: json['workplaceAddress'],
    );
  }
}
