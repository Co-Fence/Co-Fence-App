import 'package:co_fence/common/components/my_search_Text_field.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/workplace/component/workplace_list_card.dart';
import 'package:co_fence/workplace/model/workplace_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WorkplaceSearchScreen extends StatefulWidget {
  const WorkplaceSearchScreen({super.key});

  @override
  State<WorkplaceSearchScreen> createState() => _WorkplaceSearchScreenState();
}

class _WorkplaceSearchScreenState extends State<WorkplaceSearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = '';

  // 현재 검색 키워드를 _searchText에 저장
  _WorkplaceSearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _filter.dispose();
  }

  // 작업현장을 반환하는 함수
  Future<List> paginateWorkplace() async {
    final dio = Dio();

    final response = await dio.get('$ip/v22/wp/getInfo', queryParameters: {
      'page': 1,
      'size': 20,
    });
    return response.data['content'];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Workplace Search',
      child: Column(
        children: [
          const Gap(16),
          MySearchTextField(
            controller: _filter,
            focusNode: focusNode,
            hintText: 'Search Workplace',
            onPressed: () {
              setState(() {
                _filter.clear();
                _searchText = '';
                focusNode.unfocus();
              });
            },
          ),
          const Gap(16),
          FutureBuilder<List>(
            future: paginateWorkplace(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Expanded(
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    final pitem = WorkplaceModel.fromJson(
                      json: item,
                    );
                    return GestureDetector(
                      onTap: () {
                        context.go(
                          '/workplace/detail?workplaceId=${pitem.workPlaceId}',
                        );
                      },
                      child: WorkplaceListCard.fromModel(
                        model: pitem,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(16.0);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
