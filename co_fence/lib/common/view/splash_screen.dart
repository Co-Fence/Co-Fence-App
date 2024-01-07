import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/user/model/nation.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    checkToken();
    //deleteToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigateToLoginScreen() {
    GoRouter.of(context).pushReplacement('/login');
  }

  void navigateToWorkplaceScreen() {
    context.pushReplacement(
      Uri(
        path: '/workplace',
        queryParameters: {
          'workplaceId': '2',
        },
      ).toString(),
      // '/workplace?workplaceId=${ref.read(userProvider).workplaceId}',
    );
  }

  void Login() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    try {
      print(1);
      final response = await dio.get(
        '$ip/v1/parsing/refreshParsing',
        options: Options(
          headers: {
            'Authorization': '$refreshToken',
          },
        ),
      );
      final email = response.data['userEmail'];
      final resp = await dio.post(
        '$ip/v1/auth/login',
        data: {
          'email': email,
        },
      );
      if (resp.statusCode == 200) {
        final refreshToken = resp.data['refreshToken'];
        final accessToken = resp.data['accessToken'];
        await storage.write(
          key: REFRESH_TOKEN_KEY,
          value: refreshToken,
        );
        await storage.write(
          key: ACCESS_TOKEN_KEY,
          value: accessToken,
        );

        // 유저 정보 업데이트
        ref.read(userProvider.notifier).updateUser(
              name: resp.data['name'],
              email: resp.data['email'],
              role: (resp.data['roleType'] == 'ROLE_USER')
                  ? Role.USER
                  : Role.ADMIN,
              nation:
                  (resp.data['nation'] == 'KR') ? Nation.KR : Nation.Foreigner,
              phoneNumber: resp.data['phoneNumber'],
              profileImageUrl: resp.data['profileImageUrl'],
            );
        navigateToWorkplaceScreen();
      }
    } catch (e) {
      // 리프레쉬 토큰이 만료되었을 경우
      navigateToLoginScreen();
    }
  }

  // 토큰 삭제
  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    print(refreshToken);

    try {
      final response = await dio.post(
        '$ip/v1/auth/renew',
        options: Options(
          headers: {
            'Authorization': refreshToken,
          },
        ),
      );
      print(response.data);

      if (response.statusCode == 200) {
        await storage.write(
          key: ACCESS_TOKEN_KEY,
          value: response.data['renewAccessToken'],
        );
        Login();
      } else {
        print('Unexpected status code: ${response.statusCode}');
        navigateToLoginScreen();
      }
    } catch (e) {
      print('Error during token renewal: $e');
      navigateToLoginScreen();
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
            ),
          ],
        ),
      ),
    );
  }
}
