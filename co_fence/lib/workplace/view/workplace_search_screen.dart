import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/workplace/workplace_data.dart';
import 'package:co_fence/workplace/component/workplace_list_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:gap/gap.dart';

class WorkplaceSearchScreen extends StatelessWidget {
  const WorkplaceSearchScreen({super.key});

  // 작업현장을 반환하는 함수
  Future<List> paginateWorkplace() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final response = await dio.get(
      '$ip/workplace',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Workplace Search',
      child: Container(
        child: Center(
          child: FutureBuilder<List>(
            future: paginateWorkplace(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return WorkplaceListCard(
                    workplaceName: item['workplaceName'],
                    workplaceAddress: item['workplaceAddress'],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Gap(16.0);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
