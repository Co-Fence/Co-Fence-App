import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/riverpods/user_provider.dart';
import 'package:co_fence/utils/google_login.dart';
import 'package:co_fence/utils/kakao_login.dart';
import 'package:co_fence/viewModel/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final kakaoViewModel = MainViewModel(KakaoLogin());
  final googleViewModel = MainViewModel(GoogleLogin());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(150),
                // logo
                Lottie.asset(
                  'assets/lotties/app_logo.json',
                  width: 300,
                  height: 300,
                ),

                Text(
                  'Co-Fence',
                  style: GoogleFonts.lobster(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: PRIMARY_COLOR,
                  ),
                ),
                const Gap(50),
                GestureDetector(
                  onTap: () {
                    // KaKao 로그인을 시도하고 결과를 받음
                    Future<bool> kakaoLoginResult = kakaoViewModel.login();
                    kakaoLoginResult.then((value) async {
                      if (value) {
                        // 로그인 성공
                        User user = await UserApi.instance.me();
                        // 얻어온 정보로 유저 정보 업데이트
                        ref.read(userProvider.notifier).updateUser(
                              name: user.kakaoAccount?.profile?.nickname ?? '',
                              email: user.kakaoAccount?.email ?? '',
                            );
                        // 유저 모델에 저장되나 확인
                        print('유저 정보: ${ref.read(userProvider).name}');
                        print('유저 정보: ${ref.read(userProvider).email}');
                        context.go('/register');
                      } else {
                        // 로그인 실패
                        print('로그인 실패');
                      }
                    });
                  },
                  child: SizedBox(
                    width: 270,
                    child: Image.asset('assets/images/google_login.png'),
                  ),
                ),
                const Gap(30),
                GestureDetector(
                  onTap: () {
                    // 일단 실험용으로 my_page로 가게 해놓음
                    context.go('/management');
                  },
                  child: SizedBox(
                    width: 270,
                    child: Image.asset('assets/images/kakao_login.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
