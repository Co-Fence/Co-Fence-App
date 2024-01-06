import 'package:co_fence/common/const/colors.dart';
import 'package:flutter/material.dart';

class WorkplaceListCard extends StatelessWidget {
  // 작업현장 이름
  final String workplaceName;
  // 작업현장 주소
  final String workplaceAddress;

  const WorkplaceListCard({
    super.key,
    required this.workplaceName,
    required this.workplaceAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          workplaceName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Text(
          workplaceAddress,
          style: const TextStyle(fontSize: 14, color: BODY_TEXT_COLOR),
        ),
      ],
    );
  }
}
