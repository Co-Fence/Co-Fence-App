import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/utils/google_login.dart';
import 'package:co_fence/common/utils/kakao_login.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:co_fence/common/viewModel/main_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:co_fence/common/const/data.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final kakaoViewModel = MainViewModel(KakaoLogin());
  final googleViewModel = MainViewModel(GoogleLogin());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dio = Dio();
    const storage = FlutterSecureStorage();
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(70),
                // logo
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset('assets/images/app_logo.png'),
                ),
                Text(
                  'Co-Fence',
                  style: GoogleFonts.lobster(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const Gap(30),
                GestureDetector(
                  onTap: () async {
                    // 구글 로그인을 시도하고 결과를 받음
                    try {
                      final GoogleSignInAccount? googleUser =
                          await GoogleSignIn().signIn();
                      if (googleUser != null) {
                        // 로그인 성공
                        ref.read(userProvider.notifier).updateUser(
                              name: googleUser.displayName,
                              email: googleUser.email,
                            );
                        // 유저 모델에 저장되나 확인
                        print('유저 정보: ${ref.read(userProvider).name}');
                        print('유저 정보: ${ref.read(userProvider).email}');
                        // 기존에 회원가입한 회원이면 바로 홈으로
                        // /auth/checkEmail 가 true면 /auth/login post 날리고 /home으로 라우팅
                        try {
                          final response = await dio.get(
                            '$ip/api/auth/checkEmail',
                            queryParameters: {
                              'email': ref.read(userProvider).email,
                            },
                          );
                          print(response.data);
                          if (response.data == true) {
                            // 회원가입한 회원이면 로그인 로직 수행
                            final response = await dio.post(
                              '$ip/api/auth/login',
                              data: {
                                'email': ref.read(userProvider).email,
                              },
                            );
                            print(response.data);
                            if (response.statusCode == 200) {
                              // 토큰 발급받아 저장
                              final refreshToken =
                                  response.data['refreshToken'];
                              final accessToken = response.data['accessToken'];
                              await storage.write(
                                key: REFRESH_TOKEN_KEY,
                                value: refreshToken,
                              );
                              await storage.write(
                                key: ACCESS_TOKEN_KEY,
                                value: accessToken,
                              );
                            }
                          } else {
                            // 회원가입한 회원이 아니면 회원가입 페이지로
                            context.go('/register');
                          }
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        // 로그인 실패
                        print('로그인 실패');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: SizedBox(
                    width: 270,
                    child: Image.asset('assets/images/google_login.png'),
                  ),
                ),
                const Gap(30),
                GestureDetector(
                  onTap: () {
                    // KaKao 로그인을 시도하고 결과를 받음
                    Future<bool> kakaoLoginResult = kakaoViewModel.login();
                    kakaoLoginResult.then(
                      (value) async {
                        if (value) {
                          // 로그인 성공
                          User user = await UserApi.instance.me();
                          // 얻어온 정보로 유저 정보 업데이트
                          ref.read(userProvider.notifier).updateUser(
                                name:
                                    user.kakaoAccount?.profile?.nickname ?? '',
                                email: user.kakaoAccount?.email ?? '',
                              );
                          // 유저 모델에 저장되나 확인
                          print('유저 정보: ${ref.read(userProvider).name}');
                          print('유저 정보: ${ref.read(userProvider).email}');
                          // 기존에 회원가입한 회원이면 바로 홈으로
                          // /auth/checkEmail 가 true면 /auth/login post 날리고 /home으로 라우팅
                          try {
                            final response = await dio.get(
                              '$ip/api/auth/checkEmail',
                              queryParameters: {
                                'email': ref.read(userProvider).email,
                              },
                            );
                            print(response.data);
                            if (response.data == true) {
                              // 회원가입한 회원이면 로그인 로직 수행
                              final response = await dio.post(
                                '$ip/api/auth/login',
                                data: {
                                  'email': ref.read(userProvider).email,
                                },
                              );
                              print(response.data);
                              if (response.statusCode == 200) {
                                // 토큰 발급받아 저장
                                final refreshToken =
                                    response.data['refreshToken'];
                                final accessToken =
                                    response.data['accessToken'];
                                await storage.write(
                                  key: REFRESH_TOKEN_KEY,
                                  value: refreshToken,
                                );
                                await storage.write(
                                  key: ACCESS_TOKEN_KEY,
                                  value: accessToken,
                                );
                              }
                            } else {
                              // 회원가입한 회원이 아니면 회원가입 페이지로
                              context.go('/register');
                            }
                          } catch (e) {
                            print(e);
                          }
                        } else {
                          // 로그인 실패
                          print('로그인 실패');
                        }
                      },
                    );
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
