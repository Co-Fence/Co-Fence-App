import 'package:co_fence/screens/login_screen.dart';
import 'package:co_fence/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

bool authState = false;

final router = GoRouter(
  // main 스크린으로 이동할 때, 로그인이 되어있지 않으면 로그인 화면으로 이동
  redirect: (context, state) {
    if (state.uri.path == '/main' && !authState) {
      return '/login';
    }
    return null;
  },
  initialLocation: '/',
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
        GoRoute(path: ''),
      ],
    ),
  ],
);
