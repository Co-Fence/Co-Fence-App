import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/search_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/notice/model/notice_model.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NoticeMainScreen extends ConsumerStatefulWidget {
  const NoticeMainScreen({super.key});

  @override
  ConsumerState<NoticeMainScreen> createState() => _NoticeMainScreenState();
}

class _NoticeMainScreenState extends ConsumerState<NoticeMainScreen> {
  late Future<List<NoticeModel>> noticeListFuture;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final Role targetRoleType = Role.ALL;
  final bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  Future<List<NoticeModel>> fetchNoticeList() async {
    final dio = ref.watch(dioProvider);
    final resp = await dio.post('$ip/notice/search?page=0&size=20',
        options: Options(headers: {
          'accessToken': true,
        }),
        data: {
          'noticeSubject': _searchController.text,
          'targetRoletype': ref.read(roleProvider.notifier).state.code,
        });
    return resp.data['content']
        .map<NoticeModel>((e) => NoticeModel.fromJson(e))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    noticeListFuture = fetchNoticeList();
    return DefaultLayout(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 300,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            context.go('/notice/create');
          },
          isExtended: true,
          label: const Text('Create Notice'),
        ),
      ),
      context: context,
      appBarTitle: 'Notice',
      drawer: const MyDrawer(),
      child: CustomScrollView(
        slivers: [
          // 검색창
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        focusNode: focusNode,
                        controller: _searchController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10.0,
                          ),
                          hintText: 'Enter Title...',
                          hintStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  SearchButton(
                    onSearchPressed: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: Role.values
                    .map((role) => _renderSelectRoleButton(
                          role,
                          context,
                          targetRoleType,
                          ref,
                        ))
                    .toList(),
              ),
            ),
          ),

          // 테이블 헤더
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.8),
                    1: FlexColumnWidth(2),
                  },
                  border: TableBorder.all(
                    color: Colors.grey,
                  ),
                  children: const [
                    TableRow(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 60,
                          child: Center(
                            child: Text(
                              'Target',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Text(
                              'Title',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 공지사항 목록
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<List<NoticeModel>>(
                future: noticeListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (snapshot.hasData) {
                    final noticeList = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: noticeList.length,
                      itemBuilder: (context, index) {
                        final notice = noticeList[index];
                        return GestureDetector(
                          onTap: () {
                            context.go(
                                '/notice/detail?noticeId=${notice.noticeId}');
                          },
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(0.8),
                              1: FlexColumnWidth(2),
                            },
                            border: TableBorder.all(
                              color: Colors.grey,
                            ),
                            children: [
                              TableRow(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 60,
                                    child: Center(
                                      child: Text(
                                        notice.targetRoletype.displayName,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        notice.noticeSubject,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _renderSelectRoleButton(
  Role role,
  BuildContext context,
  Role targetRoleType,
  WidgetRef ref,
) {
  final targetRoleType = ref.watch(roleProvider);
  final bool isSelected = targetRoleType == role;
  return InkWell(
    onTap: () {
      ref.read(roleProvider.notifier).state = role;
    },
    child: Container(
      decoration: BoxDecoration(
        color: isSelected ? PRIMARY_COLOR : Colors.transparent,
        border: Border.all(
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      width: MediaQuery.of(context).size.width * 0.25,
      height: 30,
      child: Center(
        child: Text(
          role.displayName,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}
