import 'package:co_fence/common/const/colors.dart';
import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? appBarTitle;
  final Widget? drawer;
  final List<Widget>? actions;
  final BuildContext context;

  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const DefaultLayout({
    super.key,
    required this.context,
    required this.child,
    this.actions,
    this.backgroundColor,
    this.appBarTitle,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      drawer: drawer,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar() {
    if (appBarTitle == null) {
      return null;
    } else {
      return AppBar(
        actions: actions,
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        title: Text(
          appBarTitle!,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.white,
      );
    }
  }
}
