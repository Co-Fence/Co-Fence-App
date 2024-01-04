import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    checkToken();
    deleteToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 토큰 삭제
  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // 토큰이 유효한 지 확인하여 유효하면 워크스페이스 메인으로 이동
    // 유효하지 않으면 로그인 화면으로 이동
    try {
      final response = await dio.post(
        '$ip/v1/auth/renew',
        options: Options(
          headers: {
            'Authorization': '$refreshToken',
          },
        ),
      );
      GoRouter.of(context).pushReplacement('/workspace');
    } catch (e) {
      GoRouter.of(context).pushReplacement('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Co-Fence',
              style: GoogleFonts.lobster(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Gap(70),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
