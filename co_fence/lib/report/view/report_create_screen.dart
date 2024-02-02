// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/utils/utils.dart';
import 'package:co_fence/report/provider/report_provider.dart';
import 'package:co_fence/report/service/report_services.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:co_fence/user/service/storage_services.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:co_fence/report/model/report_status.dart';

class ReportCreateScreen extends ConsumerStatefulWidget {
  const ReportCreateScreen({super.key});

  @override
  ConsumerState<ReportCreateScreen> createState() => _ReportCreateScreenState();
}

class _ReportCreateScreenState extends ConsumerState<ReportCreateScreen> {
  final TextEditingController descriptionController = TextEditingController();

  final LIMIT_IMAGE_COUNT = 4;

  void selectImage() async {
    List<Uint8List>? selectedImages = await pickImages();
    _getImages(selectedImages);
  }

  void navigateToWorkplaceMainScreen() {
    GoRouter.of(context).go('/workplace');
  }

  // 이미지 가져오기
  void _getImages(List<Uint8List>? selectedImages) {
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
          currentPage = 0; // 새 이미지가 추가될 때 페이지를 처음으로 설정
        },
      );
    }
  }

  // 신고하기
  Future<void> report(String email, WidgetRef ref) async {
    setState(() {
      isLoading = true;
    });
    // 로딩 시작
    try {
      // 신고 내용 저장
      String res = await ReportServices().createReport(
        ref: ref,
        reportSubject:
            GoRouterState.of(context).uri.queryParameters['category']!,
        reportDetail: descriptionController.text,
        reportStatus: GoRouterState.of(context)
            .uri
            .queryParameters['category']!
            .toString(),
        reportImageUrls: ref.read(reportProvider).reportImageUrls!,
      );
      if (res == 'success') {
        // 신고 성공
        setState(() {
          isLoading = false;
        });
        if (context.mounted) {
          // 화면이 살아있다면
          showSnackBar(
            context,
            'Report successfully',
          );
          clearImage();
          navigateToWorkplaceMainScreen();
        } else {
          if (context.mounted) {
            showSnackBar(
              context,
              res,
            );
          }
        }
      }
    } catch (err) {
      // 신고 실패
      setState(() {
        isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(
          context,
          err.toString(),
        );
      }
    }
  }

  // 이미지 초기화
  void clearImage() {
    setState(() {
      images = [];
      currentPage = 0;
    });
  }

  // Storage에 이미지 업로드
  Future<void> reportImages(String email) async {
    setState(() {
      isLoading = true;
    });
    List<String> reportImageUrl = [];
    for (int i = 0; i < images.length; i++) {
      String downloadUrl = await StorageServices().uploadImageToStorage(
        childName: 'reportImage',
        email: email,
        file: images[i],
        isReport: true,
        isNotice: false,
      );
      reportImageUrl.add(downloadUrl);
    }
    ref.read(reportProvider.notifier).updateReport(
          reportImageUrls: reportImageUrl,
        );
  }

  List<Uint8List> images = [];
  int currentPage = 0;
  bool isLoading = false;
  // 페이지 컨트롤러 추가
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    return DefaultLayout(
      appBarTitle: 'Report',
      context: context,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(
                20.0,
              ),
              renderTop(context, ref),
              const Gap(
                30.0,
              ),
              renderImages(images),
              const Gap(
                30.0,
              ),
              renderDetail(descriptionController),
              const Gap(
                20.0,
              ),
              MyElevatedButton(
                buttonText: isLoading ? 'Loading...' : 'Submit',
                onPressed: () async {
                  await reportImages(userState.email);
                  await report(userState.email, ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 카테고리 화면에서 선택한 카테고리
  Widget renderTop(
    BuildContext context,
    WidgetRef ref,
  ) {
    final reportStatusState = ref.watch(reportStatusProvider);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
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
              reportStatusState.code,
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

  // 신고 내용적는 칸
  Widget renderDetail(
    TextEditingController descriptionController,
  ) {
    return TextField(
      enabled: true,
      controller: descriptionController,
      maxLines: 10,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
          borderSide: BorderSide(
            color: PRIMARY_COLOR,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
          borderSide: BorderSide(
            color: PRIMARY_COLOR,
            width: 2.0,
          ),
        ),
        hintText: '(Optional) Write down details',
      ),
    );
  }

  // 페이지 인디케이터 추가
  Widget renderPageIndicator() {
    int dotsCount =
        images.isEmpty ? 1 : images.length + 1; // 이미지가 없을 때는 최소 1로 설정
    return DotsIndicator(
      dotsCount: dotsCount,
      position: currentPage,
      decorator: const DotsDecorator(
        color: Colors.grey,
        activeColor: PRIMARY_COLOR,
      ),
    );
  }

  // 선택한 이미지 보기
  Widget renderImages(List<Uint8List>? images) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
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
      child: Column(
        children: [
          Expanded(
            child: images!.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        pickImages().then(
                          (selectedImages) {
                            _getImages(selectedImages);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 50.0,
                      ),
                    ),
                  )
                : PageView.builder(
                    controller: _pageController,
                    itemCount: images.length + 1,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      if (index == images.length) {
                        // 마지막 아이템인 경우 아이콘 버튼 추가
                        return SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: IconButton(
                            onPressed: () {
                              pickImages().then(
                                (selectedImages) {
                                  if (selectedImages != null) {
                                    _getImages(selectedImages);
                                    _pageController.jumpTo(0);
                                  }
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 50.0,
                            ),
                          ),
                        );
                      } else {
                        // 이미지 아이템인 경우
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.memory(
                            images[index],
                            width: 300.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    },
                  ),
          ),

          renderPageIndicator(), // 페이지 인디케이터 추가
        ],
      ),
    );
  }
}
