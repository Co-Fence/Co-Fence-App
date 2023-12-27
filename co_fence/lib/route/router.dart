import 'package:co_fence/screens/error_screen.dart';
import 'package:co_fence/screens/home_screen.dart';
import 'package:co_fence/screens/login_screen.dart';
import 'package:co_fence/common/view/splash_screen.dart';
import 'package:co_fence/screens/my_page_screen.dart';
import 'package:co_fence/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

bool authState = false;

final router = GoRouter(
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error.toString(),
  ),
  debugLogDiagnostics: true,
  // main 스크린으로 이동할 때, 로그인이 되어있지 않으면 로그인 화면으로 이동
  redirect: (context, state) {
    if (state.uri.path == '/main' && !authState) {
      return '/';
    }
    return null;
  },
  initialLocation: '/splash',
  routes: [
    // 로그인 화면, '/'
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
      routes: [
        // 스플래쉬 화면, '/splash'
        GoRoute(
          path: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),
        // 회원가입 화면, '/register'
        GoRoute(
          path: 'register',
          builder: (context, state) => RegisterScreen(),
        ),
        // 홈 화면, '/home'
        ShellRoute(
          builder: (context, state, child) => HomeScreen(
            child: child,
          ),
          // 홈 화면에는 마이 페이지,
          routes: [
            GoRoute(
              path: 'my_page',
              builder: (context, state) => const MyPageScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
