import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReportCreateScreen extends StatelessWidget {
  const ReportCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    final String category =
        GoRouterState.of(context).uri.queryParameters['category'] ?? '';
    return DefaultLayout(
      appBarTitle: 'Report',
      drawer: const MyDrawer(),
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(
              50.0,
            ),
            renderTop(context),
            const Gap(
              50.0,
            ),
            renderUploadImages(),
            const Gap(
              30.0,
            ),
            renderMiddle(descriptionController),
            const Gap(
              20.0,
            ),
            MyElevatedButton(
              buttonText: 'Details',
              url: '/report/create/detail?category=$category',
            ),
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
          30.0,
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

Widget renderUploadImages() {
  return Container(
    width: double.infinity,
    height: 200.0,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: PRIMARY_COLOR,
        width: 2.0,
      ),
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_a_photo,
          size: 50.0,
        ),
        Gap(
          10.0,
        ),
        Text(
          'Upload Images',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget renderMiddle(
  TextEditingController descriptionController,
) {
  return TextField(
    controller: descriptionController,
    maxLines: 3,
    decoration: const InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: PRIMARY_COLOR,
          width: 2.0,
        ),
      ),
      hintText: 'Enter a description',
    ),
  );
}
