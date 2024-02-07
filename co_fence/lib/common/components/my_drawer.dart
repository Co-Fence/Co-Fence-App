import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final userState = ref.watch(userProvider);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 180.0,
            child: DrawerHeader(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: const BoxDecoration(
                color: PRIMARY_COLOR,
              ),
              child: Text(
                "Co-Fence",
                style: GoogleFonts.lobster(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                context.go('/workplace');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text(
                'My Page',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                context.go('/mypage');
              },
            ),
          ),
          if (userState.workplaceId != null)
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text(
                  'Notice',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  context.go(
                    '/notice',
                  );
                },
              ),
            ),
          if (userState.workplaceId != null)
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text(
                  'Safety Management',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          if (userState.workplaceId != null)
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text(
                  ' - Report',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  context.go(
                    '/report',
                  );
                },
              ),
            ),
          if (userState.workplaceId != null)
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                // leading: const Icon(
                //   Icons.book_outlined,
                // ),
                title: const Text(
                  ' - Report Lists',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  context.go(
                    '/report_list',
                  );
                },
              ),
            ),
          if (userState.workplaceId != null)
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                // leading: const Icon(
                //   Icons.phone_android_outlined,
                // ),
                title: const Text(
                  'Contact',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  context.go('/contact');
                },
              ),
            ),
        ],
      ),
    );
  }
}
