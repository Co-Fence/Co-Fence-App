import 'package:co_fence/common/components/my_search_Text_field.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/model/cursor_pagination_model.dart';
import 'package:co_fence/workplace/component/workplace_list_card.dart';
import 'package:co_fence/workplace/model/workplace_model.dart';
import 'package:co_fence/workplace/provider/user_workplace_provider.dart';
import 'package:co_fence/workplace/provider/workplace_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final ScrollController controller = ScrollController();
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
    controller.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    // 현재 위치가
    // 최대 길이보다 조금 덜 되면
    // 새로운 데이터를 요청
    if (controller.position.pixels >
        controller.position.maxScrollExtent - 300) {
      ref.read(workplaceProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _filter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userWorkplaceState = ref.watch(userWorkplaceProvider);
    final data = ref.watch(workplaceProvider);
    // 데이터가 처음 로딩중이면
    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    // 에러 상황
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // CursorPagination
    // CursorPaginationRefetching
    // CursorPaginationFetchingMore
    final cp = data as CursorPagination;

    return DefaultLayout(
      context: context,
      appBarTitle: 'Workplace Search',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                controller: controller,
                itemCount: cp.data.length + 1,
                itemBuilder: (context, index) {
                  if (index == cp.data.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Center(
                        child: data is CursorPaginationFetchingMore
                            ? const CircularProgressIndicator()
                            : const SizedBox(),
                      ),
                    );
                  }
                  final pitem = cp.data[index];

                  return GestureDetector(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text('${pitem.workPlaceName}'),
                            content: const Text(
                                //출근하시겠습니까? 영어로
                                'Would you like to go to work?'),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text('Yes'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // 출근했다는 api 호출
                                  // userWorkplaceState 업데이트
                                  ref
                                      .read(userWorkplaceProvider.notifier)
                                      .updateWorkplace(WorkplaceModel(
                                        workPlaceId: pitem.workPlaceId,
                                        workPlaceName: pitem.workPlaceName,
                                        workPlaceAddress:
                                            pitem.workPlaceAddress,
                                      ));
                                  GoRouter.of(context).go(
                                    '/workplace?workplaceId=${pitem.workPlaceId}',
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: WorkplaceListCard.fromModel(
                      model: pitem,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Gap(20.0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
