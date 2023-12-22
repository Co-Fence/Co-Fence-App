import 'package:co_fence/screens/home_screen.dart';
import 'package:co_fence/kakao_login/kakao_login.dart';
import 'package:co_fence/viewModel/main_view_model.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final viewModel = MainViewModel(KakaoLogin());

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
            Text('${viewModel.isLogined}'),
            ElevatedButton(
              onPressed: () async {
                await viewModel.login();
                setState(() {});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text(
                '카카오 로그인',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await viewModel.logout();
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
