import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReportDetailScreen extends ConsumerWidget {
  final String reportId;
  const ReportDetailScreen({
    super.key,
    required this.reportId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      appBarTitle: 'Edit Report',
      actions: [
        IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('Delete Report'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text(
                        'No',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        context.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () async {
                        context.pop(context);
                        // 삭제 api 호출
                        // 다시 리스트로 이동
                        context.go('/report_list');
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
      context: context,
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
      ),
    );
  }
}
