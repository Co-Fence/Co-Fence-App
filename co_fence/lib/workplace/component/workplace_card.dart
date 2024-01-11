import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WorkplaceCard extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final IconData icon;
  const WorkplaceCard({
    super.key,
    required this.titleText,
    required this.subTitleText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            Icon(
              icon,
              color: Colors.grey[700],
              size: 120,
            ),
            const Gap(10),
            Text(
              subTitleText,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
