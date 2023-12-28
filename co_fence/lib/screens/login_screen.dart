import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/const/theme.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/utils/google_login.dart';
import 'package:co_fence/utils/kakao_login.dart';
import 'package:co_fence/viewModel/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final kakaoViewModel = MainViewModel(KakaoLogin());
  final googleViewModel = MainViewModel(GoogleLogin());

  @override
  Widget build(BuildContext context) {
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
                    // 실험용으로 회원가입으로 가게 해놓음
                    // kakaoViewModel.login();
                    context.go('/register');
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
