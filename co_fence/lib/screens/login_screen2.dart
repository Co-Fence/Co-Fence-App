import 'package:co_fence/utils/google_login.dart';
import 'package:co_fence/utils/login_platform.dart';
import 'package:co_fence/utils/kakao_login.dart';
import 'package:co_fence/viewModel/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen2> {
  final kakaoViewModel = MainViewModel(KakaoLogin());
  final googleViewModel = MainViewModel(GoogleLogin());

  final LoginPlatform _loginPlatform = LoginPlatform.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('${kakaoViewModel.isLogined}'),
            // 구글 로그인
            ElevatedButton(
              onPressed: () async {
                await googleViewModel.login();
                context.pushReplacement('/home');
              },
              child: const Text(
                '구글 로그인',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await kakaoViewModel.login();
                context.pushReplacement('/home');
              },
              child: const Text(
                '카카오 로그인',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await kakaoViewModel.logout();
                setState(() {});
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
