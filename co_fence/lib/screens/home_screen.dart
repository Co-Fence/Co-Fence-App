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
    if (index == '/home') {
      return 0;
    } else if (index == '/send') {
      return 1;
    } else if (index == '/settings') {
      return 2;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          if (value == 0) {
            GoRouter.of(context).go('/home');
          } else if (value == 1) {
            GoRouter.of(context).go('/send');
          } else if (value == 2) {
            GoRouter.of(context).go('/settings');
          }
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
      child: const Center(
        child: Text('Home'),
      ),
    );
  }
}
