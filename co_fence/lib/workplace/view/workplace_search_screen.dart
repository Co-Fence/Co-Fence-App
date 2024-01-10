import 'package:co_fence/common/components/my_search_Text_field.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/model/cursor_pagination_model.dart';
import 'package:co_fence/common/secure_storage/secure_storage.dart';
import 'package:co_fence/workplace/component/workplace_list_card.dart';
import 'package:co_fence/workplace/model/workplace_model.dart';
import 'package:co_fence/workplace/provider/workplace_provider.dart';
import 'package:co_fence/workplace/repository/workplace_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WorkplaceSearchScreen extends ConsumerStatefulWidget {
  const WorkplaceSearchScreen({super.key});

  @override
  ConsumerState<WorkplaceSearchScreen> createState() =>
      _WorkplaceSearchScreenState();
}

class _WorkplaceSearchScreenState extends ConsumerState<WorkplaceSearchScreen> {
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

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(workplaceProvider);
    if (data.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
          Expanded(
            child: ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final pitem = data[index];

                return GestureDetector(
                  onTap: () {
                    context.go(
                      '/workplace?workPlaceId=${pitem.workPlaceId}',
                    );
                  },
                  child: WorkplaceListCard.fromModel(
                    model: pitem,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Gap(50.0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
