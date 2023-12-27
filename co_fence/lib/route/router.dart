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
      return '/login';
    }
    return null;
  },
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
      routes: [
        // 로그인 화면, '/login'
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        // 회원가입 화면, '/register'
        GoRoute(
          path: 'register',
          builder: (context, state) => const RegisterScreen(),
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
