import 'package:co_fence/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    //checkToken();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  // 로고 애니메이션 초기화 메서드
  void _initAnimation() {
    // 애니메이션 컨트롤러 초기화
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // 애니메이션 지속 시간 설정
    );

    // 페이드 인 애니메이션 초기화
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // 애니메이션 시작
    _controller.forward();
  }

  void checkToken() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Co-Fence',
                style: GoogleFonts.lobster(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
