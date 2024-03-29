import 'package:co_fence/common/const/colors.dart';
import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? appBarTitle;
  final Widget? drawer;
  final List<Widget>? actions;
  final BuildContext context;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const DefaultLayout({
    super.key,
    required this.context,
    required this.child,
    this.actions,
    this.backgroundColor,
    this.appBarTitle,
    this.drawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      drawer: drawer,
      body: child,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
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
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.white,
      );
    }
  }
}
