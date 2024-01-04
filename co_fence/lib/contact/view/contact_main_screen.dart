import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class ContactMainScreen extends StatelessWidget {
  const ContactMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Contact',
      drawer: const MyDrawer(),
      child: const Center(
        child: Text('Contact'),
      ),
    );
  }
}
