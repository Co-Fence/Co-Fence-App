import 'package:co_fence/common/view/error_screen.dart';
import 'package:co_fence/contact/view/contact_main_screen.dart';
import 'package:co_fence/notice/view/notice_create_screen.dart';
import 'package:co_fence/notice/view/notice_detail_screen.dart';
import 'package:co_fence/notice/view/notice_main_screen.dart';
import 'package:co_fence/report/view/report_create_screen.dart';
import 'package:co_fence/report/view/report_detail_screen.dart';
import 'package:co_fence/report/view/report_list_screen.dart';
import 'package:co_fence/report/view/report_category_screen.dart';
import 'package:co_fence/user/view/login_screen.dart';
import 'package:co_fence/common/view/splash_screen.dart';
import 'package:co_fence/user/view/mypage_screen.dart';
import 'package:co_fence/workplace/view/workplace_main_screen.dart';
import 'package:co_fence/user/view/register_screen.dart';
import 'package:co_fence/workplace/view/workplace_search_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error.toString(),
  ),
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  routes: [
    // 로그인 화면
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),

    // 스플래쉬 화면
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // 회원가입 화면
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    // 워크플레이스 메인 화면
    GoRoute(
      path: '/workplace',
      builder: (context, state) {
        final String workplaceId =
            state.uri.queryParameters['workplaceId'] ?? '0';
        return WorkplaceMainScreen(workplaceId: workplaceId);
      },
    ),
    // 워크플레이스 검색 화면
    GoRoute(
      path: '/workplace/search',
      builder: (context, state) => const WorkplaceSearchScreen(),
    ),

    // 공지사항 화면
    GoRoute(
      path: '/notice',
      builder: (context, state) => const NoticeMainScreen(),
      routes: [
        GoRoute(
          path: 'detail/:noticeId', // 동적인 noticeId를 사용하도록 변경
          builder: (context, state) => const NoticeDetailScreen(),
        ),
        GoRoute(
          path: 'create',
          builder: (context, state) => const NoticeCreateScreen(),
        ),
      ],
    ),

    // 마이페이지 화면
    GoRoute(
      path: '/mypage',
      builder: (context, state) => const MyPageScreen(),
    ),

    // 신고 화면
    GoRoute(
      path: '/report',
      builder: (context, state) => const ReportCategoryScreen(),
      routes: [
        GoRoute(
          path: 'create',
          builder: (context, state) => const ReportCreateScreen(),
        ),
      ],
    ),

    // 신고 목록 화면
    GoRoute(
      path: '/report_list',
      builder: (context, state) => const ReportListScreen(),
      routes: [
        GoRoute(
          path: 'detail',
          builder: (context, state) => const ReportDetailScreen(),
        ),
      ],
    ),

    // 연락처 화면
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactMainScreen(),
    ),
  ],
);
