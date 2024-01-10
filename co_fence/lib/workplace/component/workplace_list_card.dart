import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/workplace/model/workplace_model.dart';
import 'package:flutter/material.dart';

class WorkplaceListCard extends StatelessWidget {
  // 작업현장 이름
  final String workPlaceName;
  // 작업현장 주소
  final String workPlaceAdress;

  const WorkplaceListCard({
    super.key,
    required this.workPlaceName,
    required this.workPlaceAdress,
  });

  factory WorkplaceListCard.fromModel({
    required WorkplaceModel model,
  }) {
    return WorkplaceListCard(
      workPlaceName: model.workPlaceName,
      workPlaceAdress: model.workPlaceAddress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          workPlaceName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Text(
          workPlaceAdress,
          style: const TextStyle(fontSize: 14, color: BODY_TEXT_COLOR),
        ),
      ],
    );
  }
}
