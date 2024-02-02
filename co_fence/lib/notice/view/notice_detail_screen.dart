import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoticeDetailScreen extends StatelessWidget {
  final String noticeId;
  const NoticeDetailScreen({
    super.key,
    required this.noticeId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 300,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Notice Create'),
                  content: const Text('Do you want to submit this notice?'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        context.pop();
                        context.go('/notice');
                      },
                    ),
                  ],
                );
              },
            );
            context.go('/notice/create');
          },
          isExtended: true,
          label: const Text('Submit'),
        ),
      ),
      context: context,
      appBarTitle: noticeId,
      child: const Center(
        child: Text(
          'detail page',
        ),
      ),
    );
  }
}
