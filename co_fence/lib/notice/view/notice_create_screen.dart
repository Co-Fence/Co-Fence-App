// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/utils/utils.dart';
import 'package:co_fence/notice/provider/notice_for_admin_provider.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:co_fence/user/service/storage_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NoticeCreateScreen extends ConsumerStatefulWidget {
  const NoticeCreateScreen({super.key});

  @override
  ConsumerState<NoticeCreateScreen> createState() => _NoticeCreateScreenState();
}

class _NoticeCreateScreenState extends ConsumerState<NoticeCreateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noticeDetailController = TextEditingController();
  final List<String> noticeImageUrl = [];
  bool isLoading = false;
  List<Uint8List> images = [];
  final LIMIT_IMAGE_COUNT = 4;

  // 이미지 가져오기
  void getImages(List<Uint8List>? selectedImages) {
    if (selectedImages != null) {
      if (selectedImages.length > LIMIT_IMAGE_COUNT) {
        showSnackBar(
          context,
          'You can select up to 4 images',
        );
        return;
      }
      setState(
        () {
          images = selectedImages;
        },
      );
    }
  }

  // Storage에 이미지 업로드
  Future<void> reportImages(String email) async {
    setState(() {
      isLoading = true;
    });
    for (int i = 0; i < images.length; i++) {
      String downloadUrl = await StorageServices().uploadImageToStorage(
        childName: 'noticeImage',
        email: email,
        file: images[i],
        isReport: false,
        isNotice: true,
      );
      noticeImageUrl.add(downloadUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  title: isLoading
                      ? const Text('Loading...')
                      : const Text('Notice Create'),
                  content: const Text('Do you want to submit this notice?'),
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
                        await reportImages(
                          ref.read(userProvider).email,
                        );
                        ref
                            .read(noticeForAdminProvider.notifier)
                            .registerNotice(
                              noticeSubject: titleController.text,
                              noticeDetail: noticeDetailController.text,
                              targetRole:
                                  ref.read(noticeForAdminProvider).targetRole,
                              noticeImageUrls: noticeImageUrl,
                            );
                        setState(() {
                          isLoading = false;
                        });
                        if (!mounted) {
                          return;
                        }
                        context.pop();
                        context.go('/notice');
                      },
                    ),
                  ],
                );
              },
            );
            context.go('/notice/create');
          },
          isExtended: true,
          label: const Text('Submit'),
        ),
      ),
      context: context,
      appBarTitle: 'Create Notice',
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const Gap(10.0),
                  // Title TextField
                  _renderTextField(
                    controller: titleController,
                    context: context,
                    ref: ref,
                  ),
                  const Gap(10.0),
                  // Role Type Dropdown Menu
                  _renderTargetRoletypeDropdownMenu(
                    context: context,
                    ref: ref,
                  ),
                  const Gap(10.0),
                  // Today Date
                  _renderTodayDate(
                    context: context,
                    ref: ref,
                  ),
                  const Gap(10.0),
                  _renderLabel(),
                  // Notice Detail TextField
                  _renderNoticeDetailTextField(
                      context: context,
                      ref: ref,
                      controller: noticeDetailController),
                  const Divider(),
                  _renderPhotoList(() {
                    // 사진 업로드
                    pickImages().then(
                      (selectedImages) {
                        if (selectedImages != null) {
                          getImages(selectedImages);
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _renderTextField({
  required TextEditingController controller,
  required BuildContext context,
  required WidgetRef ref,
}) {
  return Container(
    width: double.infinity,
    height: 50,
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Gap(
          20.0,
        ),
        const Expanded(
          flex: 1,
          child: Text(
            'Title',
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
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        const Gap(10.0),
      ],
    ),
  );
}

Widget _renderTargetRoletypeDropdownMenu({
  required BuildContext context,
  required WidgetRef ref,
}) {
  return Container(
    width: double.infinity,
    height: 50,
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Gap(
          20.0,
        ),
        const Expanded(
          flex: 1,
          child: Text(
            'Role Type',
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
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            value: ref.watch(roleProvider).displayName,
            onChanged: (value) {
              if (value != null) {
                ref.read(noticeForAdminProvider.notifier).updateNotice(
                      targetRole: Role.fromDisplayName(value.toString()),
                    );
              }
            },
            items: Role.values
                .map(
                  (role) => DropdownMenuItem(
                    value: role.displayName,
                    child: Text(
                      role.displayName,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const Gap(10.0),
      ],
    ),
  );
}

Widget _renderTodayDate({
  required BuildContext context,
  required WidgetRef ref,
}) {
  return Container(
    width: double.infinity,
    height: 50,
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Gap(
          20.0,
        ),
        const Expanded(
          flex: 1,
          child: Text(
            'Date',
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
            DateTime.now().toString().substring(0, 10),
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        const Gap(10.0),
      ],
    ),
  );
}

Widget _renderLabel() {
  return const Align(
    alignment: Alignment.centerLeft,
    child: Text(
      'Notice Detail',
      style: TextStyle(
        fontSize: 20.0,
      ),
    ),
  );
}

Widget _renderNoticeDetailTextField({
  required BuildContext context,
  required WidgetRef ref,
  required TextEditingController controller,
}) {
  return Column(
    children: [
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
  );
}

Widget _renderPhotoList(
  void Function()? onTap,
) {
  return InkWell(
    onTap: onTap,
    child: const SizedBox(
      width: double.infinity,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            size: 24.0,
          ),
          Text(
            'Upload Photo',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    ),
  );
}
