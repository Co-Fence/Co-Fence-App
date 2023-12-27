import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({
    super.key,
    required this.child,
  });

  int getIndex(BuildContext context) {
    final index = GoRouterState.of(context).uri.toString();

    Map<String, int> routeMap = {
      '/home': 0,
      '/send': 1,
      '/settings': 2,
    };

    return routeMap[index] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: NavigationBar(
        // 선택된 인덱스로 라우팅
        onDestinationSelected: (value) {
          Map<int, String> routes = {
            0: '/my_page',
            1: '/send',
            2: '/settings',
          };
          final selectedRoute = routes[value];
          context.go(selectedRoute!);
        },
        selectedIndex: getIndex(context),
        animationDuration: const Duration(
          microseconds: 1000,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.send),
            label: 'Send',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      // 하위 라우트 위젯들
      child: child,
    );
  }
}
