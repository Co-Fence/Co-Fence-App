import 'package:co_fence/kakao_login/kakao_login.dart';
import 'package:co_fence/screens/login_screen.dart';
import 'package:co_fence/viewModel/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = MainViewModel(KakaoLogin());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest API : Login"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("로그인 성공"),
            Text('${viewModel.isLogined}'),
            Text('${viewModel.user?.kakaoAccount?.profile?.nickname}'),
            ElevatedButton(
                onPressed: () async {
                  try {
                    User user = await UserApi.instance.me();
                    AccessTokenInfo tokenInfo =
                        await UserApi.instance.accessTokenInfo();
                    print('사용자 정보 요청 성공'
                        '\n회원번호: ${user.id}'
                        '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
                        '\n이메일: ${user.kakaoAccount?.email}');
                    print('회원 정보: ${tokenInfo.id}'
                        '\n만료 시간: ${tokenInfo.expiresIn}초');
                    setState(() {});
                  } catch (error) {
                    print('사용자 정보 요청 실패 $error');
                  }
                },
                child: const Text('정보출력')),
            ElevatedButton(
              onPressed: () async {
                await viewModel.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text(
                '카카오 로그아웃',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
