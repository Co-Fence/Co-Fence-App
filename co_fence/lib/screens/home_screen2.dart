import 'package:co_fence/utils/kakao_login.dart';
import 'package:co_fence/screens/login_screen2.dart';
import 'package:co_fence/viewModel/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
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
                    ScopeInfo scopeInfo = await UserApi.instance.scopes();
                    print('사용자 정보 요청 성공'
                        '\n회원번호: ${user.id}'
                        '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
                        '\n이메일: ${user.kakaoAccount?.email}');
                    print('회원 정보: ${tokenInfo.id}'
                        '\n만료 시간: ${tokenInfo.expiresIn}초');
                    print('사용자 동의 허락한 동의 항목: ${scopeInfo.scopes}');
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
                    builder: (context) => const LoginScreen2(),
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
