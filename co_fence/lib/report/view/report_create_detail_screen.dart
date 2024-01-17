import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReportCreateDetailScreen extends StatelessWidget {
  const ReportCreateDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    return DefaultLayout(
      appBarTitle: 'Report',
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            const Gap(
              50.0,
            ),
            renderTop(context),
            const Gap(
              50.0,
            ),
            renderMiddle(descriptionController),
            const Gap(
              20.0,
            ),
            const MyElevatedButton(
              buttonText: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}

Widget renderTop(
  BuildContext context,
) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.07,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: PRIMARY_COLOR,
        width: 2.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Gap(
          10.0,
        ),
        const Expanded(
          flex: 1,
          child: Text(
            'Category',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const VerticalDivider(
          color: PRIMARY_COLOR,
          thickness: 2.0,
        ),
        const Gap(
          10.0,
        ),
        Expanded(
          flex: 2,
          child: Text(
            GoRouterState.of(context).uri.queryParameters['category'] ?? '',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(10.0),
      ],
    ),
  );
}

Widget renderMiddle(
  TextEditingController descriptionController,
) {
  return TextField(
    controller: descriptionController,
    maxLines: 10,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'If you want to, Please enter a description ',
    ),
  );
}
