import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/utils/utils.dart';
import 'package:co_fence/notice/model/notice_detail_model.dart';
import 'package:co_fence/notice/provider/notice_for_admin_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NoticeDetailScreen extends ConsumerStatefulWidget {
  final String noticeId;
  const NoticeDetailScreen({
    super.key,
    required this.noticeId,
  });

  @override
  ConsumerState<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends ConsumerState<NoticeDetailScreen> {
  final TextEditingController noticeDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      noticeDetailController.text =
          ref.watch(noticeForAdminProvider).noticeDetail;
    });
  }

  @override
  void dispose() {
    noticeDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noticeId = widget.noticeId;
    final noticeDetailState = ref.watch(noticeForAdminProvider);
    return DefaultLayout(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 300,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Notice Edit'),
                  // 저장하시겠습니까? 영어로
                  content: const Text('Do you want to save?'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () async {
                        context.pop();
                        showSnackBar(context, 'Edit Successfully!');
                        context.go('/workplace');

                        // 수정 api 호출
                      },
                    ),
                  ],
                );
              },
            );
          },
          isExtended: true,
          label: const Text('Save'),
        ),
      ),
      context: context,
      appBarTitle: 'Notice Detail',
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        child: CustomScrollView(
          slivers: [
            _renderNoticeSubject(
              noticeDetailState,
            ),
            _renderDivider(),
            _renderLable(
              noticeDetailState,
            ),
            _renderNoticeDetailTextField(
              context: context,
              ref: ref,
              controller: noticeDetailController,
            ),
            _renderUploadedImageList(
              noticeDetailState,
            ),
          ],
        ),
      ),
    );
  }
}

SliverToBoxAdapter _renderNoticeSubject(
  NoticeDetailModel noticeDetailState,
) {
  return SliverToBoxAdapter(
    child: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            noticeDetailState.noticeSubject,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

SliverToBoxAdapter _renderDivider() {
  return const SliverToBoxAdapter(
    child: Divider(
      height: 20,
      thickness: 2,
      color: Colors.grey,
    ),
  );
}

SliverToBoxAdapter _renderLable(
  NoticeDetailModel noticeDetailState,
) {
  return SliverToBoxAdapter(
    child: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Writer: ${noticeDetailState.userName}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Target Role: ${noticeDetailState.targetRole.displayName}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'date: ${noticeDetailState.createdAt.substring(
              0,
              10,
            )}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

SliverToBoxAdapter _renderNoticeDetailTextField({
  required BuildContext context,
  required WidgetRef ref,
  required TextEditingController controller,
}) {
  return SliverToBoxAdapter(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(
          10,
        ),
        const Text(
          'Notice Detail',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(20),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              color: Colors.white,
              border: Border.all(
                color: PRIMARY_COLOR,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: controller,
                maxLines: 10,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

SliverList _renderUploadedImageList(
  NoticeDetailModel noticeDetailState,
) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              firebasePrefix(
                    isReport: false,
                    isNotice: true,
                  ) +
                  noticeDetailState.noticeImageUrl[index],
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      childCount: noticeDetailState.noticeImageUrl.length,
    ),
  );
}
