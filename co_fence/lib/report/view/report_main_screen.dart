import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/report/model/category.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReportMainScreen extends StatelessWidget {
  const ReportMainScreen({super.key});
  final List<Category> categories = Category.values;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Report',
      drawer: const MyDrawer(),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyElevatedButton(
              buttonText: 'Fire',
              url: '/report/create?category=Fire',
            ),
            Gap(16.0),
            MyElevatedButton(
              buttonText: 'Collapse',
              url: '/report/create?category=Collapse',
            ),
            Gap(16.0),
            MyElevatedButton(
              buttonText: 'Machine',
              url: '/report/create?category=Machine',
            ),
            Gap(16.0),
            MyElevatedButton(
              buttonText: 'Chemical',
              url: '/report/create?category=Chemical',
            ),
            Gap(16.0),
            MyElevatedButton(
              buttonText: 'Electric',
              url: '/report/create?category=Electric',
            ),
            Gap(16.0),
            MyElevatedButton(
              buttonText: 'Drop Out',
              url: '/report/create?category=DropOut',
            ),
            Gap(16.0),
            MyElevatedButton(
              buttonText: 'Explosion',
              url: '/report/create?category=Explosion',
            ),
            Gap(16.0),
            MyElevatedButton(
              buttonText: 'ETC',
              url: '/report/create?category=ETC',
            ),
          ],
        ),
      ),
    );
  }
}
