import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
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
                const Gap(80),
                GestureDetector(
                  onTap: () {
                    context.pushReplacement('/register');
                  },
                  child: SizedBox(
                    width: 270,
                    child: Image.asset('assets/images/google_login.png'),
                  ),
                ),
                const Gap(30),
                GestureDetector(
                  onTap: () {
                    context.pushReplacement('/my_page');
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
